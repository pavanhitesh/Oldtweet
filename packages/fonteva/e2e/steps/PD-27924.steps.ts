import { Before, Then, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Package_Item__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Sales_Order_Line__c,
} from '../../fonteva-schema';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28426' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28426' }, async () => {
  const deleteSalesOrder = await conn.destroy('OrderApi__Sales_Order__c', [
    state.salesOrderId as string,
    state.renewalSalesOrderId as string,
  ]);
  expect(deleteSalesOrder[0].success).toEqual(true);
  expect(deleteSalesOrder[1].success).toEqual(true);
});

Then('User renews the subscription and verifies the balanceDue,overall total should reflected in the SOL', async () => {
  state.salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(`SELECT OrderApi__Sales_Order__c
    FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get('receiptNameROE')}'`)
  ).records[0].OrderApi__Sales_Order__c as string;

  const subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Subscription__c;

  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${subscriptionId}/view`);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  state.renewalSalesOrderNumber = await salesOrderPage.getText(await salesOrderPage.salesOrderNumber);

  const packagedItemId = (
    await conn.query<Fields$OrderApi__Package_Item__c>(
      `SELECT OrderApi__Item__c FROM OrderApi__Package_Item__c WHERE OrderApi__Package__c = '${await browser.sharedStore.get(
        'itemId',
      )}' AND OrderApi__Item__c <> null`,
    )
  ).records[0].OrderApi__Item__c;

  const packagedItemPrice = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT OrderApi__Price__c FROM OrderApi__Item__c where Id = '${packagedItemId}'`,
    )
  ).records[0].OrderApi__Price__c;

  const renewalSalesOrderLineResponse = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id ,OrderApi__Balance_Due__c, OrderApi__Overall_Total__c FROM OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__c in (Select Id from OrderApi__Sales_Order__c where Name = '${
        state.renewalSalesOrderNumber as string
      }') and OrderApi__Item__c = '${packagedItemId}'`,
    )
  ).records[0];
  state.renewalSalesOrderId = renewalSalesOrderLineResponse.Id;
  expect(renewalSalesOrderLineResponse.OrderApi__Balance_Due__c).toEqual(packagedItemPrice);
  expect(renewalSalesOrderLineResponse.OrderApi__Overall_Total__c).toEqual(packagedItemPrice);
});
