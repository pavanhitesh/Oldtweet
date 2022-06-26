import { Before, Then, After } from '@cucumber/cucumber';
import { add, format, differenceInCalendarMonths } from 'date-fns';
import moment from 'moment';
import math = require('mathjs');
import {
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Scheduled_Payment__c,
  Fields$OrderApi__Item__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28268' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28268' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscription as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteRenewalSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.renewalSO as string);
  expect(deleteRenewalSO.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.originalSO as string);
  expect(deleteSO.success).toEqual(true);
});

Then('User verifies the schedule payments dates and amounts for {string} renewal', async (item: string) => {
  const renewalTerm = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c, OrderApi__Term_Start_Date__c, OrderApi__Term_End_Date__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}')`,
    )
  ).records[0];
  const originalTerm = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Grace_Period_End_Date__c, OrderApi__Sales_Order__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${renewalTerm.OrderApi__Subscription__c}'`,
    )
  ).records;
  state.originalSO = originalTerm[0].OrderApi__Sales_Order__c as string;
  state.renewalSO = originalTerm[1].OrderApi__Sales_Order__c as string;
  state.subscription = renewalTerm.OrderApi__Subscription__c as string;
  const gracePeriod = format(
    add(Date.parse(originalTerm[0].OrderApi__Grace_Period_End_Date__c as string), { days: 2 }),
    'yyyy-MM-dd',
  );
  expect(renewalTerm.OrderApi__Term_Start_Date__c).toEqual(gracePeriod);
  const termMonths = differenceInCalendarMonths(
    new Date(renewalTerm.OrderApi__Term_End_Date__c as string),
    new Date(renewalTerm.OrderApi__Term_Start_Date__c as string),
  );
  const schedulePayments = (
    await conn.query<Fields$OrderApi__Scheduled_Payment__c>(
      `SELECT OrderApi__Scheduled_Date__c, OrderApi__Amount__c FROM OrderApi__Scheduled_Payment__c WHERE OrderApi__Sales_Order__c IN (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}')`,
    )
  ).records;
  expect(schedulePayments.length).toEqual(termMonths + 1);
  for (let index = 0; index < schedulePayments.length; index += 1) {
    expect(schedulePayments[index].OrderApi__Scheduled_Date__c).toEqual(moment().add(index, 'M').format('yyyy-MM-DD'));
  }
  expect(schedulePayments[0].OrderApi__Amount__c).toEqual(0);
  const itemPrice = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${item}'`,
    )
  ).records[0].OrderApi__Price__c;
  const schedulePaymentsPriceBE = Number(
    math
      .chain(math.number(itemPrice))
      .multiply(math.number(termMonths + 1))
      .divide(12)
      .divide(termMonths + 1)
      .done(),
  ).toFixed(2);
  let schedulePaymentsTotal = 0;
  for (let index = 1; index < schedulePayments.length - 1; index += 1) {
    schedulePaymentsTotal += schedulePayments[index].OrderApi__Amount__c as number;
    expect(schedulePayments[index].OrderApi__Amount__c).toEqual(schedulePaymentsPriceBE);
  }
  expect(Number(schedulePayments[schedulePayments.length - 1].OrderApi__Amount__c).toFixed(2)).toEqual(
    Number(math.chain(math.number(itemPrice)).subtract(math.number(schedulePaymentsTotal)).done().toFixed(2)),
  );
});
