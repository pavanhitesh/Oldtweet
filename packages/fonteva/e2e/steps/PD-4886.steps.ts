import { Before, Then, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Transaction__c,
  Fields$OrderApi__Renewal__c,
} from '../../fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28908' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28908' }, async () => {
  const subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(subscriptionId);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});

Then('User verifies the deferred transactions should equal the prorated price', async () => {
  await loginPage.sleep(MilliSeconds.XXS);
  const salesOrder = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id, OrderApi__Overall_Total__c FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  state.salesOrderId = salesOrder.Id;
  const deferredTransactions = (
    await conn.query<Fields$OrderApi__Transaction__c>(
      `SELECT OrderApi__Total_Debits__c FROM OrderApi__Transaction__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}' AND OrderApi__Type__c = 'Revenue Recognition'`,
    )
  ).records;
  let deferredTransactionsTotal = 0;
  deferredTransactions.forEach((record) => {
    deferredTransactionsTotal += record.OrderApi__Total_Debits__c as number;
  });
  expect(deferredTransactionsTotal.toFixed(2)).toEqual((salesOrder.OrderApi__Overall_Total__c as number).toFixed(2));
});
