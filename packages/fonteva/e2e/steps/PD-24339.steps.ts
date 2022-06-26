import { Before, Given, After, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import {
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';

let salesOrderId: string;

Before({ tags: '@TEST_PD-28783' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28783' }, async () => {
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});

Given('User changes the customer entity from contact to account {string}', async (accountName: string) => {
  await rapidOrderEntryPage.changeCustomerEntityForOrder(accountName);
  expect(await rapidOrderEntryPage.getText(await rapidOrderEntryPage.customerEntitySelected)).toEqual(accountName);
});

Then(
  'User verifies SalesOrder,SalesOrderLine and Subscription are with entity type Account for new subscription',
  async () => {
    salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(`SELECT OrderApi__Sales_Order__c
        FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get('receiptNameROE')}'`)
    ).records[0].OrderApi__Sales_Order__c as string;
    const salesOrderEntity = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Entity__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrderId}'`,
      )
    ).records[0].OrderApi__Entity__c;
    expect(salesOrderEntity).toEqual('Account');

    const salesOrderLineEntity = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Entity__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'`,
      )
    ).records[0].OrderApi__Entity__c;
    expect(salesOrderLineEntity).toEqual('Account');

    const subscriptionEntity = (
      await conn.query<Fields$OrderApi__Subscription__c>(
        `SELECT OrderApi__Entity__c FROM OrderApi__Subscription__c WHERE Id IN (SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
          'SalesOrderNumber',
        )}')`,
      )
    ).records[0].OrderApi__Entity__c;
    expect(subscriptionEntity).toEqual('Account');
  },
);
