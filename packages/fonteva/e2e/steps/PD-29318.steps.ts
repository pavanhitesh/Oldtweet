import { Given, Before, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Renewal__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { manageSubscriptionPage } from '../../pages/portal/manage-subscription.page';

Before({ tags: '@TEST_PD-29444' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29444' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);
});

Given('User should be able to click on manage subscription and verify renew button is displayed', async () => {
  const subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}')`,
    )
  ).records[0].OrderApi__Subscription__c;
  subscriptionPage.subscriptionToManage = subscriptionId;
  await subscriptionPage.click(await subscriptionPage.manageSubscription);
  await manageSubscriptionPage.waitForPresence(await manageSubscriptionPage.renew);
  expect(await manageSubscriptionPage.isDisplayed(await manageSubscriptionPage.renew)).toEqual(true);
});
