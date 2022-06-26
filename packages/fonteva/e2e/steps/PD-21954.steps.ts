import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Sales_Order__c, Fields$OrderApi__Subscription__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { subscriptionToRenewPage } from '../../pages/portal/subscriptions-to-renew.page';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-28843' }, async () => {
  await loginPage.open('/');
  if (await loginPage.isDisplayed(await loginPage.username)) {
    await loginPage.login();
  }
});

After({ tags: '@TEST_PD-28843' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);

  const subscriptionId = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT Id FROM OrderApi__Subscription__c WHERE Id = '${await browser.sharedStore.get('subscriptionId')}'`,
    )
  ).records[0].Id;

  const subscriptionDeleted = await conn.destroy('OrderApi__Subscription__c', subscriptionId as string);
  expect(subscriptionDeleted.success).toEqual(true);
});

Then('User verifies auto renew tile is {string}', async (action: string) => {
  await subscriptionToRenewPage.waitForPresence(await subscriptionToRenewPage.renewHeader);
  await subscriptionToRenewPage.identifyRenewSubscriptionBlock((await browser.sharedStore.get('itemName')) as string);
  if (action === 'enabled') {
    expect(await subscriptionToRenewPage.isEnabled(await subscriptionToRenewPage.autoRenewCheckBox)).toEqual(true);
    expect(await subscriptionToRenewPage.isDisplayed(await subscriptionToRenewPage.autoRenewText)).toEqual(true);
  } else {
    expect(await subscriptionToRenewPage.isEnabled(await subscriptionToRenewPage.autoRenewCheckBox)).toEqual(false);
    expect(await subscriptionToRenewPage.isSelected(await subscriptionToRenewPage.autoRenewCheckBox)).toEqual(false);
    expect(await subscriptionToRenewPage.isDisplayed(await subscriptionToRenewPage.noAutoRenewText)).toEqual(true);
  }
});
