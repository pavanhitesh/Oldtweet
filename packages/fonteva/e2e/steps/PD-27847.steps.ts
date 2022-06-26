import { After, Before, DataTable, Given, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { salesOrderLinePage } from '../../pages/salesforce/salesorderline.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import {
  Fields$OrderApi__Price_Rule__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string | string[] } = {};

Before({ tags: '@TEST_PD-29378' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29378' }, async () => {
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});

Given(`User exit to sales order page and navigate to sales order line details page`, async () => {
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
  await rapidOrderEntryPage.waitForPresence(await salesOrderPage.salesOrderNumber);
  localSharedData.salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id as string;
  await salesOrderLinePage.open(
    `/lightning/r/OrderApi__Sales_Order__c/${localSharedData.salesOrderId}/related/OrderApi__Sales_Order_Lines__r/view`,
  );
  await salesOrderLinePage.waitForPresence(await salesOrderLinePage.newButton);
  expect(await salesOrderLinePage.isDisplayed(await salesOrderLinePage.newButton)).toEqual(true);
});

Given(`User create a manual subscription sale order line with following details`, async (itemDetails: DataTable) => {
  const itemDetailsData = itemDetails.hashes();
  await itemDetailsData.reduce(async (memo, itemData) => {
    await memo;
    await salesOrderLinePage.click(await salesOrderLinePage.newButton);
    await salesOrderLinePage.waitForPresence(await salesOrderLinePage.itemClassTextBox);
    await salesOrderLinePage.createSubscriptionSalesItem(
      itemData.itemClass,
      itemData.itemName,
      itemData.businessGroup,
      itemData.priceRule,
      itemData.subscriptionPlan,
      await salesOrderLinePage.getDate('MM/dd/yyyy', 0, 2, 0),
      await salesOrderLinePage.getDate('MM/dd/yyyy', 0, 3, 0),
    );
  }, undefined);
  await salesOrderLinePage.waitForPresence(await salesOrderLinePage.newButton);
  expect(await salesOrderLinePage.isDisplayed(await salesOrderLinePage.newButton)).toEqual(true);
});

Then(
  'User validates the sale price is populated with price rule {string} for the item {string}',
  async (ruleName: string, itemName: string) => {
    const salesPrice = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Sale_Price__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}' and OrderApi__Item__r.Name = '${itemName}'`,
      )
    ).records[0].OrderApi__Sale_Price__c;
    const configuredPrice = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${itemName}' and Name = '${ruleName}'`,
      )
    ).records[0].OrderApi__Price__c;
    expect(salesPrice).toEqual(configuredPrice);
  },
);
