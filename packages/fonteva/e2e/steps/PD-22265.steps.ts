import { After, Before, Then } from '@cucumber/cucumber';
import {
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-27735' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should update the term end date to the past date and renew the subscription', async () => {
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
  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${state.subscriptionId}/view`);
  await subscriptionPage.waitForPresence(await subscriptionPage.header);
  const termEndDate = await subscriptionPage.getDate('MM/dd/yyyy', 0, -2);
  const activatedDate = await conn.tooling
    .executeAnonymous(`OrderApi__Subscription__c activatedDate = [Select Id from OrderApi__Subscription__c Where Id = '${state.subscriptionId}'];
  activatedDate.OrderApi__Activated_Date__c = date.parse('${termEndDate}');
  update activatedDate;`);
  expect(activatedDate.success).toEqual(true);
  const response = await conn.tooling
    .executeAnonymous(`OrderApi__Renewal__c status = [Select Id from OrderApi__Renewal__c Where OrderApi__Subscription__c = '${state.subscriptionId}'];
  status.OrderApi__Term_End_Date__c = date.parse('${termEndDate}');
  update status;`);
  expect(response.success).toEqual(true);
  const termIsActive = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Is_Active__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${state.subscriptionId}'`,
    )
  ).records[0].OrderApi__Is_Active__c;
  expect(termIsActive).toBe(true);
  const originalSubscription = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT OrderApi__Is_Active__c, OrderApi__In_Grace_Period__c FROM OrderApi__Subscription__c WHERE Id = '${state.subscriptionId}'`,
    )
  ).records[0];
  expect(originalSubscription.OrderApi__Is_Active__c).toBe(true);
  expect(originalSubscription.OrderApi__In_Grace_Period__c).toBe(true);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  await salesOrderPage.click(await salesOrderPage.readyForPayment);
  await salesOrderPage.click(await salesOrderPage.applyPayment);
  await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="accessibility title"]'));
  await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment)).toEqual(true);
});

Then('User should be able to verify new term date is active and old term date is inactive', async () => {
  await subscriptionPage.sleep(MilliSeconds.XXS);
  const termStatus = await conn.query<Fields$OrderApi__Renewal__c>(
    `SELECT OrderApi__Is_Active__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${state.subscriptionId}'`,
  );
  expect(termStatus.records[0].OrderApi__Is_Active__c).toEqual(false);
  expect(termStatus.records[1].OrderApi__Is_Active__c).toEqual(true);
});

After({ tags: '@TEST_PD-27735' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
