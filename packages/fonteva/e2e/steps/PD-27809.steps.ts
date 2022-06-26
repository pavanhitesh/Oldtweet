import { Before, Then, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { salesOrderLinePage } from '../../pages/salesforce/salesorderline.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

const localSharedData: { [key: string]: string | boolean | number } = {};

Before({ tags: '@TEST_PD-28528' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User verifies the Price Override option is disabled in sales order line', async () => {
  await salesOrderLinePage.sleep(MilliSeconds.XXS);
  localSharedData.salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}'`,
    )
  ).records[0].OrderApi__Sales_Order__c as string;

  localSharedData.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await localSharedData.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;

  const isPriceOverrideSelected = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT OrderApi__Price_Override__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${await localSharedData.salesOrderId}'`,
    )
  ).records[0].OrderApi__Price_Override__c;

  expect(isPriceOverrideSelected).toEqual(false);
});

Then(`User opens the subscription record created and clicks renew`, async () => {
  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${localSharedData.subscriptionId}/view`);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  localSharedData.renewSalesOrder = await salesOrderPage.getSalesOrderId();
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
});

Then(
  'User verifies the sale price and total price are updated on renewal sales order line when the item is changed to {string}',
  async (item: string) => {
    localSharedData.salesOrderLineID = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${await localSharedData.renewSalesOrder}' AND OrderApi__Item__r.Name = '${await browser.sharedStore.get(
          'itemName',
        )}'`,
      )
    ).records[0].Id as string;

    await salesOrderLinePage.open(
      `/lightning/r/OrderApi__Sales_Order_Line__c/${await localSharedData.salesOrderLineID}/view`,
    );
    await salesOrderLinePage.click(await salesOrderLinePage.editItemName);
    await salesOrderLinePage.click(await salesOrderLinePage.clearSelection);

    await salesOrderLinePage.slowTypeFlex(await salesOrderLinePage.editItemTextBox, item);
    await salesOrderLinePage.sleep(MilliSeconds.XXS);
    await browser.keys(['ArrowDown']);
    await browser.keys(['Enter']);
    await salesOrderLinePage.click(await salesOrderLinePage.saveEdit);
    await subscriptionPage.sleep(MilliSeconds.XXS);

    const solRecord = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Sale_Price__c, OrderApi__Total__c, OrderApi__Price_Override__c FROM OrderApi__Sales_Order_Line__c WHERE  Id = '${await localSharedData.salesOrderLineID}'`,
      )
    ).records[0];

    const newItemPrice = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE Name = '${item}'`,
      )
    ).records[0].OrderApi__Price__c;

    expect(solRecord.OrderApi__Sale_Price__c).toEqual(newItemPrice);
    expect(solRecord.OrderApi__Total__c).toEqual(newItemPrice);
    expect(solRecord.OrderApi__Price_Override__c).toEqual(false);
  },
);

After({ tags: '@TEST_PD-28528' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);

  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);

  const renewSoID = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${(await localSharedData.renewSalesOrder) as string}'`,
    )
  ).records[0].Id;

  const deleteRenewSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(renewSoID);
  expect(deleteRenewSO.success).toEqual(true);
});
