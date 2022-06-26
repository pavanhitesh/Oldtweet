import { After, Before, Then } from '@cucumber/cucumber';
import math = require('mathjs');
import moment = require('moment');
import {
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const state: { [key: string]: string | number | boolean } = {};
let newDate: moment.MomentInput;

Before({ tags: '@TEST_PD-28289' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User updates {string} months to Calender End Month and {string} days to advance calender days for {string} plan',
  async (additionalMonth: string, advanceCalDays: string, subPlan: string) => {
    // get current year month and add 4 months to it
    newDate = moment().add(additionalMonth, 'months');
    const updatedDate = moment(newDate, 'YYYY-MM-DD');
    const day = updatedDate.format('DD');
    const monthNum = updatedDate.format('MM');
    const monthName = updatedDate.format('MMMM');
    await browser.sharedStore.set('getNewDate', moment(newDate).format('YYYY-MM-DD') as unknown as string);
    const subscriptionPlanUpdate = await conn.tooling.executeAnonymous(`
    OrderApi__Subscription_Plan__c  subsPlan = [Select OrderApi__Calendar_End_Month__c, OrderApi__Calendar_End_Day__c from OrderApi__Subscription_Plan__c Where Name = '${subPlan}'];
    subsPlan.OrderApi__Calendar_End_Month__c = '${monthNum} - ${monthName}';
    subsPlan.OrderApi__Calendar_End_Day__c = '${day}';
    subsPlan.OrderApi__Advanced_Calendar_Days__c = ${advanceCalDays};
    update subsPlan;`);
    expect(subscriptionPlanUpdate.success).toEqual(true);
  },
);

Then('User verifies Total Dues and Term End Date for {string} item', async (item: string) => {
  await subscriptionPage.sleep(MilliSeconds.XXS); // subscription Creation
  state.salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}'`,
    )
  ).records[0].OrderApi__Sales_Order__c as string;

  const itemPrice = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${item}'`,
    )
  ).records[0].OrderApi__Price__c;

  const term = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Dues_Total__c, OrderApi__Term_End_Date__c, OrderApi__Term_Start_Date__c, OrderApi__Subscription__c	
      FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0];

  state.subscriptionId = term.OrderApi__Subscription__c as string;

  const subscriptionActivationDate = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT OrderApi__Activated_Date__c FROM OrderApi__Subscription__c where Id = '${state.subscriptionId}'`,
    )
  ).records[0].OrderApi__Activated_Date__c;

  // check subscription activation date is today
  const currentDate = moment().format('YYYY-MM-DD');
  expect(currentDate).toEqual(subscriptionActivationDate as string);

  const monthDifference = moment(new Date(newDate as string)).diff(
    new Date(subscriptionActivationDate as string),
    'months',
  );

  const checkTermEndDate = moment()
    .add({ months: 12 + monthDifference })
    .format('YYYY-MM-DD');
  expect(checkTermEndDate).toEqual(term.OrderApi__Term_End_Date__c as string);

  expect(
    Number(
      math
        .chain(math.number(itemPrice))
        .multiply(math.number(monthDifference + 12))
        .divide(12)
        .done(),
    ).toFixed(2),
  ).toEqual(Number(term.OrderApi__Dues_Total__c).toFixed(2));
});

After({ tags: '@TEST_PD-28289' }, async () => {
  await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
});
