import { After, Before, Then, When } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Package_Item__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

const localSharedData: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-28469' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28469' }, async () => {
  const updateIncludedItemToActive = await conn.tooling.executeAnonymous(`
  OrderApi__Item__c includedItem = [SELECT OrderApi__Is_Active__c FROM OrderApi__Item__c WHERE Id = '${localSharedData.includedItemId}'];
  includedItem.OrderApi__Is_Active__c = true;
  update includedItem;`);
  expect(updateIncludedItemToActive.success).toEqual(true);

  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);

  const originalSoId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${localSharedData.originalSalesOrderNumber}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy([originalSoId, localSharedData.renewedSOId] as string[]);

  expect(deleteSO[0].success).toEqual(true);
  expect(deleteSO[1].success).toEqual(true);
});

When(`User makes one of the Included Item of {string} to Inactive`, async (subscriptionItem: string) => {
  localSharedData.includedItemId = (
    await conn.query<Fields$OrderApi__Package_Item__c>(
      `SELECT OrderApi__Item__c FROM OrderApi__Package_Item__c WHERE OrderApi__Package__c IN (SELECT Id FROM OrderApi__Item__c WHERE Name = '${subscriptionItem}')`,
    )
  ).records[0].OrderApi__Item__c as string;

  const updateIncludedItemToInactive = await conn.tooling.executeAnonymous(`
  OrderApi__Item__c includedItem = [SELECT OrderApi__Is_Active__c FROM OrderApi__Item__c WHERE Id = '${localSharedData.includedItemId}'];
  includedItem.OrderApi__Is_Active__c = false;
  update includedItem;`);
  expect(updateIncludedItemToInactive.success).toEqual(true);
});

When(`User renews the Subscription created from backend`, async () => {
  localSharedData.originalSalesOrderNumber = (await browser.sharedStore.get('SalesOrderNumber')) as string;

  localSharedData.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN (SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${localSharedData.originalSalesOrderNumber}')`,
    )
  ).records[0].OrderApi__Subscription__c as string;

  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${localSharedData.subscriptionId}/view`);
  await subscriptionPage.waitForPresence(await subscriptionPage.header);
  expect(await subscriptionPage.isDisplayed(await subscriptionPage.header)).toBe(true);

  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  localSharedData.renewedSOId = await (
    await (await salesOrderPage.getUrl()).split('/OrderApi__Sales_Order__c/')[1]
  ).split('/')[0];
});

Then(`User verifies the newly created Sales Order doesn't include the inactive Included Item`, async () => {
  const renewedSalesOrderLines = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id, OrderApi__Item__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.renewedSOId}'`,
    )
  ).records;

  expect(renewedSalesOrderLines.length).toBe(2);

  renewedSalesOrderLines.forEach((renewedSalesOrderLine) => {
    expect(renewedSalesOrderLine.OrderApi__Item__c).not.toBe(localSharedData.includedItemId);
  });
});
