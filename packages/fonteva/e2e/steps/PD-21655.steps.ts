import { After, Before, Then } from '@cucumber/cucumber';
import math = require('mathjs');
import {
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Subscription_Line__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Item__c,
} from '../../fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { taxAndShippingPage } from '../../pages/salesforce/tax-and-shipping.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-27669' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should add optional Item to {string} item and go to apply payment page', async (item: string) => {
  await rapidOrderEntryPage.expandItemtoViewDetails(item);
  await rapidOrderEntryPage.waitForPresence(await rapidOrderEntryPage.optionalPackageItemsCard);
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.optionalItemCheckBox);
  await rapidOrderEntryPage.waitForEnable(await rapidOrderEntryPage.optionalPackageItemQty);
  await rapidOrderEntryPage.waitForEnable(await rapidOrderEntryPage.go);
  await rapidOrderEntryPage.waitForPresence(await rapidOrderEntryPage.go);
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.go);
  await taxAndShippingPage.click(await taxAndShippingPage.continue);
  await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment)).toEqual(true);
});

Then('User should renew the subscription to {string} item on backend', async (item: string) => {
  await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
  state.salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}'`,
    )
  ).records[0].OrderApi__Sales_Order__c as string;
  state.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  browser.sharedStore.set('subscriptionToRenewBE', state.subscriptionId);
  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${state.subscriptionId}/view`);
  await subscriptionPage.waitForPresence(await subscriptionPage.header);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  await salesOrderPage.click(await salesOrderPage.readyForPayment);
  await salesOrderPage.click(await salesOrderPage.applyPayment);
  const itemConfig = (
    await conn.query<Fields$OrderApi__Item__c>(
      `Select OrderApi__Is_Taxable__c, OrderApi__Require_Shipping__c from OrderApi__item__c where Name= '${item}'`,
    )
  ).records[0];
  // FIXME: bug created once fixed, remove the code.
  await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="accessibility title"]'));
  if ((itemConfig.OrderApi__Is_Taxable__c || itemConfig.OrderApi__Require_Shipping__c) === true) {
    await taxAndShippingPage.click(await taxAndShippingPage.continue);
  }
  await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment)).toEqual(true);
});

Then(
  'User should verify the {string} term, {string} subscription lines and {string} sales orderline is created',
  async (totalTerm: string, totalSubsLine: string, totalSOL: string) => {
    await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
    const termCount = await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT Id from OrderApi__Renewal__c where OrderApi__Subscription__c = '${state.subscriptionId}'`,
    );
    expect(math.number(totalTerm)).toEqual(termCount.records.length);

    const subsLineCount = await conn.query<Fields$OrderApi__Subscription_Line__c>(
      `SELECT Id from OrderApi__Subscription_Line__c where OrderApi__Subscription__c = '${state.subscriptionId}'`,
    );
    expect(math.number(totalSubsLine)).toEqual(subsLineCount.records.length);

    const solCount = await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT Id from OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__c IN(Select OrderApi__Sales_Order__c from OrderApi__Renewal__c where OrderApi__Subscription__c = '${state.subscriptionId}' and OrderApi__Is_Active__c = false)`,
    );
    expect(math.number(totalSOL)).toEqual(solCount.records.length);
  },
);

After({ tags: '@TEST_PD-27669' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
