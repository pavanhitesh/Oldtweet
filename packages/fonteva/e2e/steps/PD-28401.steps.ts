import { After, Before, Then } from '@cucumber/cucumber';
import moment = require('moment');
import math = require('mathjs');
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-28404' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Before({ tags: '@TEST_PD-28403' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Before({ tags: '@TEST_PD-28402' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User verifies {string} item Total Dues, Paid Date, Term Start Date and Term End Date for {string} checkout',
  async (item: string, checkoutPage: string) => {
    await subscriptionPage.sleep(MilliSeconds.XXS); // subscription Creation
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

    const term = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT OrderApi__Dues_Total__c, OrderApi__Renewed_Date__c, OrderApi__Term_End_Date__c, OrderApi__Term_Start_Date__c, OrderApi__Subscription__c	
    FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
      )
    ).records[0];

    state.subscriptionId = term.OrderApi__Subscription__c as string;

    const subscriptionActivationDate = (
      await conn.query<Fields$OrderApi__Subscription__c>(
        `SELECT OrderApi__Activated_Date__c FROM OrderApi__Subscription__c where Id = '${state.subscriptionId}'`,
      )
    ).records[0].OrderApi__Activated_Date__c as string;

    const currentDate = moment().format('YYYY-MM-DD');
    expect(currentDate).toEqual(term.OrderApi__Renewed_Date__c as string);
    expect(currentDate).toEqual(term.OrderApi__Term_Start_Date__c as string);
    expect(currentDate).toEqual(subscriptionActivationDate);

    const itemPrice = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${item}'`,
      )
    ).records[0].OrderApi__Price__c;

    const monthDifference = moment(new Date(`${await browser.sharedStore.get('getNewDate')}`)).diff(
      new Date(subscriptionActivationDate as string),
      'months',
    );

    // If adv calender days = 180, add one full year and if adv calender days = 30 then add monthDifference
    if (checkoutPage === 'portal') {
      const checkTermEndDate = moment()
        .add({ months: 12 + monthDifference + 1 })
        .format('YYYY-MM-DD');
      expect(checkTermEndDate).toEqual(term.OrderApi__Term_End_Date__c as string);
      expect(
        Number(
          math
            .chain(math.number(itemPrice))
            .multiply(math.number(monthDifference + 12 + 1))
            .divide(12)
            .done(),
        ).toFixed(2),
      ).toEqual(Number(term.OrderApi__Dues_Total__c).toFixed(2));
    } else {
      const checkTermEndDate = moment()
        .add({ months: monthDifference + 1 })
        .format('YYYY-MM-DD');
      expect(checkTermEndDate).toEqual(term.OrderApi__Term_End_Date__c as string);
      expect(
        Number(
          math
            .chain(math.number(itemPrice))
            .multiply(math.number(monthDifference + 1))
            .divide(12)
            .done(),
        ).toFixed(2),
      ).toEqual(Number(term.OrderApi__Dues_Total__c).toFixed(2));
    }
  },
);

After({ tags: '@TEST_PD-28402' }, async () => {
  await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
});

After({ tags: '@TEST_PD-28403' }, async () => {
  await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
});

After({ tags: '@TEST_PD-28404' }, async () => {
  await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
});
