import { When, Before, Then, After } from '@cucumber/cucumber';
import { lastDayOfMonth, format, differenceInCalendarMonths } from 'date-fns';
import math = require('mathjs');
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Scheduled_Payment__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28518' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28518' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesorderId as string);
  expect(deleteSO.success).toEqual(true);
});

When(
  'User updates the subscription date and activation date to last day of the current month on sales order line',
  async () => {
    const lastDateOfMonth = format(lastDayOfMonth(new Date()), 'MM/dd/yyyy');
    const activatedDate = await conn.tooling
      .executeAnonymous(`OrderApi__Sales_Order_Line__c record = [SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
      'SalesOrderNumber',
    )}' AND OrderApi__Item__r.Name = '${await browser.sharedStore.get('itemName')}'];
  record.OrderApi__Auto_Calculate_Activation_Date__c = false;
  record.OrderApi__Subscription_Start_Date__c = date.parse('${lastDateOfMonth}');
  record.OrderApi__Activation_Date__c = date.parse('${lastDateOfMonth}');
  update record;`);
    expect(activatedDate.success).toEqual(true);
  },
);

Then('User verifies the number of schedule payments created and price of first installment', async () => {
  await receiptPage.sleep(MilliSeconds.XXS);
  const termDetails = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Term_End_Date__c, OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  state.subscriptionId = termDetails.OrderApi__Subscription__c;
  const termMonths = differenceInCalendarMonths(
    new Date(termDetails.OrderApi__Term_End_Date__c as string),
    new Date(format(new Date(), 'MM/dd/yyyy') as string),
  );
  const schedulePayments = (
    await conn.query<Fields$OrderApi__Scheduled_Payment__c>(
      `SELECT OrderApi__Amount__c FROM OrderApi__Scheduled_Payment__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records;
  expect(schedulePayments.length).toEqual(termMonths + 1);
  expect(schedulePayments[0].OrderApi__Amount__c).toEqual(0);
  const itemPrice = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${await browser.sharedStore.get(
        'itemName',
      )}'`,
    )
  ).records[0].OrderApi__Price__c;
  const salesOrderRecord = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id, OrderApi__Overall_Total__c, OrderApi__Total__c FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  state.salesorderId = salesOrderRecord.Id;
  expect(
    Number(
      math
        .chain(math.number(itemPrice))
        .multiply(math.number(termMonths + 1))
        .divide(12)
        .done(),
    ).toFixed(2),
  ).toEqual(Number(salesOrderRecord.OrderApi__Overall_Total__c).toFixed(2));
  expect(
    Number(
      math
        .chain(math.number(itemPrice))
        .multiply(math.number(termMonths + 1))
        .divide(12)
        .divide(termMonths + 1)
        .done(),
    ).toFixed(2),
  ).toEqual(Number(salesOrderRecord.OrderApi__Total__c).toFixed(2));
});
