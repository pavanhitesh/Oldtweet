import { Then, Before, After } from '@cucumber/cucumber';
import math = require('mathjs');
import moment from 'moment';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__EPayment__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Subscription_Plan__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-28361' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User verifies salesOrder, salesOrderLine, receipt and epayment total for {string} checkout',
  async (checkoutPage: string) => {
    await loginPage.sleep(MilliSeconds.XXS);
    const itemPrice = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c = '${await browser.sharedStore.get(
          'itemName',
        )}'`,
      )
    ).records[0].OrderApi__Price__c as unknown as string;

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
        `SELECT OrderApi__Subscription__c,OrderApi__Days_To_Lapse__c, OrderApi__Term_Start_Date__c, OrderApi__Term_End_Date__c, OrderApi__Grace_Period_End_Date__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
      )
    ).records[0];
    state.termStartDate = term.OrderApi__Term_Start_Date__c as string;
    state.termEndDate = term.OrderApi__Term_End_Date__c as string;
    state.gracePeriodEndDate = term.OrderApi__Grace_Period_End_Date__c as string;
    state.subscriptionId = term.OrderApi__Subscription__c as string;
    state.daystoLapse = term.OrderApi__Days_To_Lapse__c as number;

    state.monthDifference = moment(new Date(state.termEndDate)).diff(new Date(state.termStartDate), 'months');

    const totalPrice = Number(
      math
        .chain(math.number(itemPrice))
        .multiply(math.number(state.monthDifference + 1))
        .divide(12)
        .divide(state.monthDifference + 1)
        .done(),
    ).toFixed(2);

    const salesOrderLine = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Subscription_Plan__c, OrderApi__Sale_Price__c from OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
      )
    ).records[0];
    state.subscriptionPlan = salesOrderLine.OrderApi__Subscription_Plan__c as string;
    expect(totalPrice).toEqual(Number(salesOrderLine.OrderApi__Sale_Price__c).toFixed(2));

    const salesOrderTotal = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Total__c FROM OrderApi__Sales_Order__c WHERE Id = '${state.salesOrderId}'`,
      )
    ).records[0].OrderApi__Total__c;
    expect(totalPrice).toEqual(Number(salesOrderTotal).toFixed(2));
    const receiptTotal = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Total__c FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
      )
    ).records[0].OrderApi__Total__c;
    expect(totalPrice).toEqual(Number(receiptTotal).toFixed(2));

    const ePaymentTotal = (
      await conn.query<Fields$OrderApi__EPayment__c>(
        `SELECT OrderApi__Total__c FROM OrderApi__EPayment__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
      )
    ).records[0].OrderApi__Total__c;
    expect(totalPrice).toEqual(Number(ePaymentTotal).toFixed(2));
  },
);

Then('User verifies term start date, term end date and grace period end date on term and subscription', async () => {
  expect(state.termStartDate).toEqual(moment().format('YYYY-MM-DD'));
  const checkTermEndDate = moment()
    .add({ days: state.daystoLapse as number })
    .format('YYYY-MM-DD');
  expect(checkTermEndDate).toEqual(state.termEndDate);
  const gracePeriodDays = (
    await conn.query<Fields$OrderApi__Subscription_Plan__c>(
      `SELECT OrderApi__Grace_Period__c FROM OrderApi__Subscription_Plan__c WHERE Id = '${state.subscriptionPlan}'`,
    )
  ).records[0].OrderApi__Grace_Period__c;

  const subscriptionGracePeriodEndDate = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT OrderApi__Grace_Period_End_Date__c FROM OrderApi__Subscription__c WHERE Id = '${state.subscriptionId}'`,
    )
  ).records[0].OrderApi__Grace_Period_End_Date__c;
  const checkGracePeriodEndDate = moment(`${state.termEndDate}`)
    .add({ days: gracePeriodDays as number })
    .format('YYYY-MM-DD');
  expect(checkGracePeriodEndDate).toEqual(state.gracePeriodEndDate);
  expect(checkGracePeriodEndDate).toEqual(subscriptionGracePeriodEndDate);
});

After({ tags: '@REQ_PD-23215' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
