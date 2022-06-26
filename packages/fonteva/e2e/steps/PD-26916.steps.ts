import { Before, Given, When, Then } from '@cucumber/cucumber';
import { jsonObject } from 'expect-webdriverio';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$OrderApi__Sales_Order_Line__c } from '../../fonteva-schema';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { conn } from '../../shared/helpers/force.helper';

let referenceSalesOrderLineItemDetails: Fields$OrderApi__Sales_Order_Line__c;

Before({ tags: '@TEST_PD-27783' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(
  'User should be able to add {string} item with quantity {int} on rapid order entry',
  async (itemName: string, quantity: number) => {
    await rapidOrderEntryPage.addItemToOrder(itemName, quantity);
    await rapidOrderEntryPage.waitForPresence(await rapidOrderEntryPage.go);
    expect(await rapidOrderEntryPage.verifyItemAddedToOrder(itemName)).toBe(true);
  },
);
When('User select the sales order line item and create credit Notes', async () => {
  const url = await salesOrderPage.getUrl();
  const salesOrderid = url.split('/')[6];
  const salesOrderLineItemDetails = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`SELECT Id,OrderApi__Sale_Price__c,
  OrderApi__Overall_Total__c,
  OrderApi__Balance_Due__c,
  OrderApi__Quantity__c,
  OrderApi__Item__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrderid}'`)
  ).records[0];
  referenceSalesOrderLineItemDetails = salesOrderLineItemDetails;
  expect(salesOrderLineItemDetails.Id).not.toBeNull();
  const response = (
    await conn.apex.post<jsonObject>('/services/apexrest/FDService/AdjustmentService', {
      type: 'adjustment',
      adjustmentType: 'negative',
      recordType: 'orderline',
      records: [
        {
          id: salesOrderLineItemDetails.Id,
          salesOrder: salesOrderid,
          item: salesOrderLineItemDetails.OrderApi__Item__c,
          balanceDue: salesOrderLineItemDetails.OrderApi__Balance_Due__c as number,
          overallTotal: salesOrderLineItemDetails.OrderApi__Overall_Total__c as number,
          isAdjustment: false,
        },
      ],
    })
  ).data;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const creditNotes = await conn.apex.post<any>('/services/apexrest/FDService/AdjustmentService', {
    type: 'creditnote',
    recordType: 'orderline',
    records: response,
  });
  expect(`${creditNotes.data[0].total}`).toEqual(`-${salesOrderLineItemDetails.OrderApi__Balance_Due__c as number}`);
});

Then(
  'User validates the newly sales Order line item with quantity as 1 and sales price as overall total of the parent sales order',
  async () => {
    const salesOrderLineItemDetails = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`SELECT
  OrderApi__Sale_Price__c,
  OrderApi__Overall_Total__c,
  OrderApi__Total__c,
  OrderApi__Quantity__c, OrderApi__Is_Adjustment__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order_Line__c = '${referenceSalesOrderLineItemDetails.Id}'`)
    ).records[0];
    expect(`${salesOrderLineItemDetails.OrderApi__Sale_Price__c}`).toEqual(
      `-${referenceSalesOrderLineItemDetails.OrderApi__Overall_Total__c}`,
    );
    expect(`${salesOrderLineItemDetails.OrderApi__Overall_Total__c}`).toEqual(
      `-${referenceSalesOrderLineItemDetails.OrderApi__Overall_Total__c}`,
    );
    expect(`${salesOrderLineItemDetails.OrderApi__Total__c}`).toEqual(
      `-${referenceSalesOrderLineItemDetails.OrderApi__Overall_Total__c}`,
    );
    expect(salesOrderLineItemDetails.OrderApi__Quantity__c).toEqual(1);
    expect(salesOrderLineItemDetails.OrderApi__Is_Adjustment__c).toEqual(true);
  },
);
