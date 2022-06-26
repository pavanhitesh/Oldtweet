import { Before, Then, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Renewal__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { subscriptionPage } from '../../pages/portal/subscription.page';

Before({ tags: '@TEST_PD-28975' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28975' }, async () => {
  const updateItemToActive = await conn.tooling.executeAnonymous(`
  OrderApi__Item__c item = [SELECT OrderApi__Is_Active__c FROM OrderApi__Item__c WHERE Name = '${await browser.sharedStore.get(
    'itemName',
  )}'];
  item.OrderApi__Is_Active__c = true;
  update item;`);
  expect(updateItemToActive.success).toEqual(true);

  const subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}')`,
    )
  ).records[0].OrderApi__Subscription__c;
  const subscriptionDeleted = await conn.destroy('OrderApi__Subscription__c', subscriptionId as string);
  expect(subscriptionDeleted.success).toEqual(true);

  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then('User updates the item as inactive', async () => {
  const updateItemToInactive = await conn.tooling.executeAnonymous(`
  OrderApi__Item__c item = [SELECT OrderApi__Is_Active__c FROM OrderApi__Item__c WHERE Name = '${await browser.sharedStore.get(
    'itemName',
  )}'];
  item.OrderApi__Is_Active__c = false;
  update item;`);
  expect(updateItemToInactive.success).toEqual(true);
});

Then('User verifies the renew button is {string} in active subscription', async (action: string) => {
  await subscriptionPage.refreshBrowser();
  if (action === 'displayed') expect(await subscriptionPage.isDisplayed(await subscriptionPage.renew)).toBe(true);
  else expect(await subscriptionPage.isDisplayed(await subscriptionPage.renew)).toBe(false);
});
