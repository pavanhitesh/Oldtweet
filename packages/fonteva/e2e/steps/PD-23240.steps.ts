import { Given, Before, DataTable } from '@cucumber/cucumber';
import { differenceInCalendarMonths } from 'date-fns';
import math = require('mathjs');
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Scheduled_Payment__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__EPayment__c,
  Fields$OrderApi__Assignment__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-28137' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(
  'User should be able to see the prorated price and assigments for the subscription {string} for {string} checkout',
  async (item: string, checkoutPage: string, members: DataTable) => {
    await loginPage.sleep(MilliSeconds.XXS);
    let salesOrder;
    if (checkoutPage === 'portal') {
      salesOrder = await browser.sharedStore.get('portalSO');
    } else {
      salesOrder = (
        await conn.query<Fields$OrderApi__Receipt__c>(
          `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
            'receiptNameROE',
          )}'`,
        )
      ).records[0].OrderApi__Sales_Order__c;
    }
    const term = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT Id, OrderApi__Term_End_Date__c, OrderApi__Term_Start_Date__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${salesOrder}'`,
      )
    ).records[0];
    const termMonths = differenceInCalendarMonths(
      new Date(term.OrderApi__Term_End_Date__c as string),
      new Date(term.OrderApi__Term_Start_Date__c as string),
    );
    const schedulePayments = (
      await conn.query<Fields$OrderApi__Scheduled_Payment__c>(
        `SELECT Id FROM OrderApi__Scheduled_Payment__c WHERE OrderApi__Sales_Order__c = '${salesOrder}'`,
      )
    ).records;
    expect(schedulePayments.length).toEqual(termMonths + 1);
    const itemRecord = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT Id, OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${item}'`,
      )
    ).records[0];
    const salesOrderRecord = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Overall_Total__c, OrderApi__Is_Posted__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrder}'`,
      )
    ).records[0];
    expect(salesOrderRecord.OrderApi__Is_Posted__c).toEqual(true);
    expect(
      Number(
        math
          .chain(math.number(itemRecord.OrderApi__Price__c))
          .multiply(math.number(termMonths + 1))
          .divide(12)
          .done(),
      ).toFixed(2),
    ).toEqual(Number(salesOrderRecord.OrderApi__Overall_Total__c).toFixed(2));
    const salesOrderLineSalePrice = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Sale_Price__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrder}' AND OrderApi__Item__c = '${itemRecord.Id}'`,
      )
    ).records[0].OrderApi__Sale_Price__c;
    expect(
      Number(
        math
          .chain(math.number(itemRecord.OrderApi__Price__c))
          .multiply(math.number(termMonths + 1))
          .divide(12)
          .divide(termMonths + 1)
          .done(),
      ).toFixed(2),
    ).toEqual(Number(salesOrderLineSalePrice).toFixed(2));
    const receiptTotal = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Total__c FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__c = '${salesOrder}'`,
      )
    ).records[0].OrderApi__Total__c;
    expect(
      Number(
        math
          .chain(math.number(itemRecord.OrderApi__Price__c))
          .multiply(math.number(termMonths + 1))
          .divide(12)
          .divide(termMonths + 1)
          .done(),
      ).toFixed(2),
    ).toEqual(Number(receiptTotal).toFixed(2));
    const epaymentTotal = (
      await conn.query<Fields$OrderApi__EPayment__c>(
        `SELECT OrderApi__Total__c FROM OrderApi__EPayment__c WHERE OrderApi__Sales_Order__c = '${salesOrder}'`,
      )
    ).records[0].OrderApi__Total__c;
    expect(Number(receiptTotal).toFixed(2)).toEqual(Number(epaymentTotal).toFixed(2));
    const orderData = members.hashes();
    await orderData.reduce(async (memo, member) => {
      await memo;
      const assignmentName = (
        await conn.query<Fields$OrderApi__Assignment__c>(
          `SELECT OrderApi__Full_Name__c, OrderApi__Is_Active__c, OrderApi__Is_Primary__c FROM OrderApi__Assignment__c WHERE OrderApi__Term__c = '${term.Id}' AND OrderApi__Assignment_Role__c IN (SELECT Id FROM OrderApi__Assignment_Role__c WHERE Name = '${member.role}')`,
        )
      ).records[0];
      if (member.name === 'Guest') {
        expect(assignmentName.OrderApi__Full_Name__c).toEqual(
          `${await browser.sharedStore.get('guestFirstName')} ${await browser.sharedStore.get('guestLastName')}`.trim(),
        );
      } else {
        expect(assignmentName.OrderApi__Full_Name__c).toEqual(member.name);
      }
      expect(assignmentName.OrderApi__Is_Active__c.toString()).toEqual(member.isActive);
      expect(assignmentName.OrderApi__Is_Primary__c.toString()).toEqual(member.isPrimary);
    }, undefined);
  },
);
