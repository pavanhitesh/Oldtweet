import { After, Before, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Receipt_Line__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
} from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28236' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28236' }, async () => {
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then(
  `User verifies tax percentage on Sales order Lines and Receipt Lines for Item {string}`,
  async (itemName: string) => {
    localSharedData.salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0].OrderApi__Sales_Order__c as string;

    const expectedTaxPercent = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT OrderApi__Tax_Percent__c FROM OrderApi__Item__c WHERE Id In (SELECT OrderApi__Item__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}' AND OrderApi__Item_Name__c != '${itemName}')`,
      )
    ).records[0].OrderApi__Tax_Percent__c;

    const salesOrderLineItemRecords = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT Id, OrderApi__Tax_Percent__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}' AND OrderApi__Item_Name__c != '${itemName}'`,
      )
    ).records[0];

    expect(salesOrderLineItemRecords.OrderApi__Tax_Percent__c).toEqual(expectedTaxPercent);

    const receiptLineTaxPercent = (
      await conn.query<Fields$OrderApi__Receipt_Line__c>(
        `SELECT OrderApi__Tax_Percent__c FROM OrderApi__Receipt_Line__c WHERE OrderApi__Sales_Order_Line__c = '${salesOrderLineItemRecords.Id}'`,
      )
    ).records[0].OrderApi__Tax_Percent__c;

    expect(receiptLineTaxPercent).toEqual(expectedTaxPercent);
  },
);
