/* eslint-disable no-console */
import { Then, Before, DataTable, After } from '@cucumber/cucumber';
import math = require('mathjs');
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Scheduled_Payment__c,
  Fields$OrderApi__EPayment__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Assignment__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import * as data from '../data/PD-28174.json';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-28177' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User verifies salesOrder and salesOrderLine total for {string} checkout', async (checkoutPage: string) => {
  await loginPage.sleep(MilliSeconds.XXS);
  const itemRecord = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT Id, OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${data.item}'`,
    )
  ).records[0];
  state.itemPrice = itemRecord.OrderApi__Price__c as unknown as string;
  // get sales order Id
  if (checkoutPage === 'portal') {
    state.salesOrderId = (await browser.sharedStore.get('portalSO')) as string;
  } else {
    state.salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0].OrderApi__Sales_Order__c as string;
  }

  // get sales order line records
  const salesOrderLineRecord = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT OrderApi__Enable_Auto_Renew__c, OrderApi__Sale_Price__c from OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0];
  expect(salesOrderLineRecord.OrderApi__Enable_Auto_Renew__c).toEqual(true);
  expect(Number(math.chain(math.number(state.itemPrice)).divide(12).done()).toFixed(2)).toEqual(
    Number(salesOrderLineRecord.OrderApi__Sale_Price__c).toFixed(2),
  );

  // get sales order records
  const salesOrderRecord = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Overall_Total__c, OrderApi__Is_Posted__c, OrderApi__Require_Payment_Method__c FROM OrderApi__Sales_Order__c WHERE Id = '${state.salesOrderId}'`,
    )
  ).records[0];
  expect(salesOrderRecord.OrderApi__Is_Posted__c).toEqual(true);
  expect(salesOrderRecord.OrderApi__Require_Payment_Method__c).toEqual(true);
  expect(Number(math.chain(math.number(state.itemPrice)).done()).toFixed(2)).toEqual(
    Number(salesOrderRecord.OrderApi__Overall_Total__c).toFixed(2),
  );
});

Then('User verifies {string} Schedule payment is created', async (totalSchedulePayment: string) => {
  const schedulePaymentCount = await conn.query<Fields$OrderApi__Scheduled_Payment__c>(
    `SELECT Id FROM OrderApi__Scheduled_Payment__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
  );
  expect(math.number(totalSchedulePayment)).toEqual(schedulePaymentCount.records.length);
});

Then('User verifies receipt and epayment total', async () => {
  const receiptTotal = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Total__c FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0].OrderApi__Total__c;
  expect(Number(math.chain(math.number(state.itemPrice)).divide(12).done()).toFixed(2)).toEqual(
    Number(receiptTotal).toFixed(2),
  );
  const ePaymentRecords = (
    await conn.query<Fields$OrderApi__EPayment__c>(
      `SELECT OrderApi__Total__c, OrderApi__Message__c FROM OrderApi__EPayment__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0];
  expect('Succeeded!').toEqual(ePaymentRecords.OrderApi__Message__c);
  expect(Number(receiptTotal).toFixed(2)).toEqual(Number(ePaymentRecords.OrderApi__Total__c).toFixed(2));
});

Then('User verifies assignments and only {string} term is created', async (termCount: string, members: DataTable) => {
  const term = await conn.query<Fields$OrderApi__Renewal__c>(
    `SELECT Id, OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
  );
  expect(math.number(termCount)).toEqual(term.records.length);
  state.subscriptionId = term.records[0].OrderApi__Subscription__c;
  const orderData = members.hashes();
  await orderData.reduce(async (memo, member) => {
    await memo;
    const assignmentName = (
      await conn.query<Fields$OrderApi__Assignment__c>(
        `SELECT OrderApi__Full_Name__c, OrderApi__Is_Active__c, OrderApi__Is_Primary__c FROM OrderApi__Assignment__c WHERE OrderApi__Term__c = '${term.records[0].Id}' AND OrderApi__Assignment_Role__c IN (SELECT Id FROM OrderApi__Assignment_Role__c WHERE Name = '${member.role}')`,
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
});

After({ tags: '@REQ_PD-28174' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
