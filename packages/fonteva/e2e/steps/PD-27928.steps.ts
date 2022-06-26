/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28341' }, async () => {
  state.itemClassId = (await conn.query(`SELECT Id from OrderApi__Item_Class__c where Name = 'Subscription Class'`))
    .records[0].Id as string;

  state.bussinessGroupId = (await conn.query(`SELECT Id from OrderApi__Business_Group__c where Name = 'Foundation'`))
    .records[0].Id as string;
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28341' }, async () => {
  const deleteSalesOrder = await conn.destroy('OrderApi__Sales_Order__c', state.salesOrderId as string);
  expect(deleteSalesOrder.success).toEqual(true);
});

Then('User verifies the created sales Order Posting Status "Posted"', async () => {
  const salesOrderResponse = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id, OrderApi__Posting_Status__c FROM OrderApi__Sales_Order__c WHERE Id in (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}')`,
    )
  ).records[0];
  state.salesOrderId = salesOrderResponse.Id as string;
  expect(salesOrderResponse.OrderApi__Posting_Status__c).toEqual('Posted');
});
