import { After, Before, Then } from '@cucumber/cucumber';
import {
  Fields$OrderApi__Price_Rule__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Subscription_Plan__c,
} from '../../fonteva-schema';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@TEST_PD-29350' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User clicks renew on subscription and update sales order line subscription plan with {string} plan',
  async (subscriptionPlan: string) => {
    await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation

    const subsPlanId = (
      await conn.query<Fields$OrderApi__Subscription_Plan__c>(
        `SELECT Id FROM OrderApi__Subscription_Plan__c WHERE Name = '${subscriptionPlan}'`,
      )
    ).records[0].Id as string;

    localSharedData.salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0].OrderApi__Sales_Order__c as string;

    localSharedData.subscriptionId = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
      )
    ).records[0].OrderApi__Subscription__c as string;

    await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${localSharedData.subscriptionId}/view`);
    await subscriptionPage.waitForPresence(await subscriptionPage.header);
    await subscriptionPage.click(await subscriptionPage.renew);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    localSharedData.newSalesOrderId = (await (await salesOrderPage.getUrl())
      .split('/OrderApi__Sales_Order__c/')[1]
      .split('/')[0]) as string;
    const updateSubsPlan = await conn.tooling.executeAnonymous(`
    OrderApi__Sales_Order_Line__c SOL = [Select OrderApi__Subscription_Plan__c  from OrderApi__Sales_Order_Line__c Where OrderApi__Sales_Order__c = '${localSharedData.newSalesOrderId}'];
    SOL.OrderApi__Subscription_Plan__c = '${subsPlanId}';
	  update SOL;`);
    expect(updateSubsPlan.success).toEqual(true);
  },
);

Then(
  'User verifies price rule {string} for {string} item is applied',
  async (priceRuleName: string, itemName: string) => {
    const newSOLPrice = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Sale_Price__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.newSalesOrderId}'`,
      )
    ).records[0].OrderApi__Sale_Price__c;

    const configuredPrice = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${itemName}' and Name = '${priceRuleName}'`,
      )
    ).records[0].OrderApi__Price__c;

    expect(newSOLPrice).toEqual(configuredPrice);
  },
);

After({ tags: '@TEST_PD-29350' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
  const deleteNewSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.newSalesOrderId as string);
  expect(deleteNewSO.success).toEqual(true);
});
