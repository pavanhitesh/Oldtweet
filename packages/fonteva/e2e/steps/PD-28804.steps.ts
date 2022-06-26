/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Renewal__c,
} from '../../fonteva-schema';
import * as data from '../data/PD-28804.json';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29232' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User {string} should be able to renew the subscription and validate the sales order lines',
  async (user: string) => {
    const expectedSalesOrderLines = data.salesOrderLines;
    subscriptionPage.activeSubscription = 'Auto_SubscriptionItemWithTwoRenewalPaths';
    await subscriptionPage.click(await subscriptionPage.requiredActiveSubscription);
    await subscriptionPage.click(await assignMemberPage.AddToCart);
    await shoppingCartPage.waitForPresence(await shoppingCartPage.cartCheckout);
    state.renewalSalesOrderId = JSON.parse(
      (
        await browser.getCookies([
          `apex__${await browser.sharedStore.get('organizationId')}-fonteva-community-shopping-cart`,
        ])
      )[0].value,
    ).salesOrderId;
    await shoppingCartPage.click(await shoppingCartPage.cartCheckout);
    await checkoutPage.waitForEnable(await creditCardComponent.buttonProcessPayment);
    await checkoutPage.click(await creditCardComponent.buttonProcessPayment);
    const salesOrderLines = (
      await conn.query(
        `SELECT Id,OrderApi__Item__r.Name FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Contact__r.Name = '${user}'`,
      )
    ).records;
    const areAllItemsPresent = expectedSalesOrderLines.map((requiredSalesOrderLine) =>
      salesOrderLines.some((salesOrderLine) => salesOrderLine.OrderApi__Item__r.Name === requiredSalesOrderLine),
    );
    expect(areAllItemsPresent).not.toContain(false);
  },
);

Then('User should be able to close and post sales order', async () => {
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  state.salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id from OrderApi__Sales_Order__c WHERE Name='${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id as string;
  const closeResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c SO = [Select Id from OrderApi__Sales_Order__c Where Id = '${state.salesOrderId}'];
  SO.OrderApi__Is_Closed__c = true;
  update SO;`);
  expect(closeResponse.success).toEqual(true);
  const postResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c SO = [Select Id from OrderApi__Sales_Order__c Where Id = '${state.salesOrderId}'];
  SO.OrderApi__Is_Posted__c = true;
  update SO;`);
  expect(postResponse.success).toEqual(true);
});

After({ tags: '@TEST_PD-29232' }, async () => {
  const salesOrderLineData:
    | Fields$OrderApi__Sales_Order_Line__c
    | { Id: string; OrderApi__Sales_Order__r: { Id: string } } = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id,OrderApi__Sales_Order__r.Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0] as unknown as { Id: string; OrderApi__Sales_Order__r: { Id: string } };
  const subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(subscriptionId);
  expect(deleteSubscription.success).toEqual(true);
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    salesOrderLineData.OrderApi__Sales_Order__r.Id,
  );
  expect(salesOrderDeleted.success).toEqual(true);
  const renewalSalesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', state.renewalSalesOrderId);
  expect(renewalSalesOrderDeleted.success).toEqual(true);
});
