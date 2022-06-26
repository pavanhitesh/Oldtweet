import { After, Before, Then } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Renewal__c, Fields$OrderApi__Subscription__c } from '../../fonteva-schema';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-27171' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should update the subscription start date to {string} future date', async (date: string) => {
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);

  const response = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order_Line__c SOL = [Select OrderApi__Subscription_Start_Date__c from OrderApi__Sales_Order_Line__c Where OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
    'SalesOrderId',
  )}'];
  SOL.OrderApi__Subscription_Start_Date__c = date.parse('${date}');
  update SOL;`);
  expect(response.success).toEqual(true);
});

Then('User should close and post the sales order', async () => {
  const closeResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c SO = [Select Id from OrderApi__Sales_Order__c Where Id = '${await browser.sharedStore.get(
    'SalesOrderId',
  )}'];
  SO.OrderApi__Is_Closed__c = true;
  update SO;`);
  expect(closeResponse.success).toEqual(true);

  const postResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c SO = [Select Id from OrderApi__Sales_Order__c Where Id = '${await browser.sharedStore.get(
    'SalesOrderId',
  )}'];
  SO.OrderApi__Is_Posted__c = true;
  update SO;`);
  expect(postResponse.success).toEqual(true);
});

Then(
  'User should check isCancelled checkbox and verify the subscription is in {string} status',
  async (status: string) => {
    await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
    const response = await conn.tooling.executeAnonymous(`
  OrderApi__Subscription__c Subscription = 
  [Select OrderApi__Sales_Order_Line__c from OrderApi__Subscription__c where OrderApi__Sales_Order_Line__c IN
    (SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c='${await browser.sharedStore.get(
      'SalesOrderId',
    )}')];
  Subscription.OrderApi__Is_Cancelled__c = true;
  update Subscription;`);
    expect(response.success).toEqual(true);
    state.subscriptionId = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'SalesOrderId',
        )}'`,
      )
    ).records[0].OrderApi__Subscription__c as string;
    await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${state.subscriptionId}/view`);
    await subscriptionPage.waitForPresence(await subscriptionPage.header);
    await subscriptionPage.click(await subscriptionPage.status);
    await subscriptionPage.click(await subscriptionPage.Save);
    const subscriptionStatus = (
      await conn.query<Fields$OrderApi__Subscription__c>(
        `SELECT OrderApi__Status__c from OrderApi__Subscription__c where Id = '${state.subscriptionId}'`,
      )
    ).records[0].OrderApi__Status__c;
    expect(subscriptionStatus).toEqual(status);
    await subscriptionPage.waitForPresence(await subscriptionPage.status);
  },
);

After({ tags: '@TEST_PD-27171' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy(`${await browser.sharedStore.get('SalesOrderId')}`);
  expect(deleteSO.success).toEqual(true);
});
