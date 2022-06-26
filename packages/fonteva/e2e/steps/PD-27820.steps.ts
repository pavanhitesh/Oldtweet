/* eslint-disable no-restricted-syntax */
import { After, Before, Then } from '@cucumber/cucumber';
import { format } from 'date-fns';
import { Fields$OrderApi__Sales_Order__c, Fields$OrderApi__Scheduled_Payment__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { contactPage } from '../../pages/salesforce/contact.page';
import { manageSubscriptionPage } from '../../pages/portal/manage-subscription.page';
import { conn } from '../../shared/helpers/force.helper';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28293' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28293' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);

  const subscriptionId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Subscription__c WHERE Id = '${await browser.sharedStore.get('subscriptionId')}'`,
    )
  ).records[0].Id;

  const subscriptionDeleted = await conn.destroy('OrderApi__Subscription__c', subscriptionId as string);
  expect(subscriptionDeleted.success).toEqual(true);
});

Then('User should be able to update payment method of subscription', async () => {
  state.oldPaymentMethodId = (
    await conn.query<Fields$OrderApi__Scheduled_Payment__c>(
      `SELECT  OrderApi__Saved_Payment_Method__c FROM OrderApi__Scheduled_Payment__c WHERE 
        OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get('SalesOrderNumber')}' `,
    )
  ).records[0].OrderApi__Saved_Payment_Method__c as string;
  state.newPaymentMethodId = (
    await contactPage.addNewPaymentMethod((await browser.sharedStore.get('contactName')) as string, 'visa', '1111')
  ).id as string;
  await manageSubscriptionPage.refreshBrowser();

  await manageSubscriptionPage.click(await manageSubscriptionPage.updatePaymentMethod);
  await manageSubscriptionPage.selectByAttribute(
    await manageSubscriptionPage.savedPaymentMethod,
    'value',
    state.newPaymentMethodId,
  );
  await manageSubscriptionPage.click(await manageSubscriptionPage.done);
  await manageSubscriptionPage.waitForAjaxCall();
  expect(await manageSubscriptionPage.isDisplayed(await manageSubscriptionPage.updatePaymentMethod)).toEqual(true);
});

Then('User verifies payment method updated only in future scheduled payments', async () => {
  const scheduledPayments = (
    await conn.query<Fields$OrderApi__Scheduled_Payment__c>(
      `SELECT  OrderApi__Saved_Payment_Method__c, OrderApi__Scheduled_Date__c FROM OrderApi__Scheduled_Payment__c WHERE 
        OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get('SalesOrderNumber')}' `,
    )
  ).records;
  for (const scheduledPayment of scheduledPayments) {
    if (
      scheduledPayment.OrderApi__Scheduled_Date__c &&
      scheduledPayment.OrderApi__Scheduled_Date__c > format(new Date(), 'yyyy-MM-dd')
    )
      expect(scheduledPayment.OrderApi__Saved_Payment_Method__c).toEqual(state.newPaymentMethodId);
    else expect(scheduledPayment.OrderApi__Saved_Payment_Method__c).toEqual(state.oldPaymentMethodId);
  }
});
