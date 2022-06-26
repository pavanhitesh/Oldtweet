/* eslint-disable @typescript-eslint/no-explicit-any */
import { Before, Then, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { commonPage } from '../../pages/salesforce/_common.page';
import { subscriptionLinePage } from '../../pages/salesforce/subscription-line.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28520' }, async () => {
  state.bussinessGroupId = (await conn.query(`SELECT Id from OrderApi__Business_Group__c where Name = 'Foundation'`))
    .records[0].Id as string;

  state.itemClassId = (await conn.query(`SELECT Id from OrderApi__Item_Class__c where Name = 'Subscription Class'`))
    .records[0].Id as string;

  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28520' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);

  const subscriptionDeleted = await conn.destroy('OrderApi__Subscription__c', state.subscriptionId as string);
  expect(subscriptionDeleted.success).toEqual(true);
});

Then('User verifies the total dues in term record', async () => {
  const term = (
    await conn.query(
      `SELECT OrderApi__Subscription__c, OrderApi__Dues_Total__c, OrderApi__Subscription__r.OrderApi__Subscription_Dues_Total__c FROM 
      OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN (SELECT OrderApi__Sales_Order__c FROM 
        OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get('receiptNameROE')}')`,
    )
  ).records[0];
  state.subscriptionId = term.OrderApi__Subscription__c;
  expect(term.OrderApi__Dues_Total__c).toEqual(term.OrderApi__Subscription__r.OrderApi__Subscription_Dues_Total__c);
});

Then('User edits and save the subscription line item', async () => {
  const subscriptionLineId = (
    await conn.query(
      `SELECT Id FROM OrderApi__Subscription_Line__c WHERE OrderApi__Subscription__c = '${state.subscriptionId}'`,
    )
  ).records[0].Id;
  const updateSubscriptionLine = `OrderApi__Subscription_Line__c SL = [SELECT OrderApi__Item__c, OrderApi__Is_Amendment__c FROM OrderApi__Subscription_Line__c Where Id = '${subscriptionLineId}'];
    SL.OrderApi__Item__c = null;
    SL.OrderApi__Is_Amendment__c = true;
    update SL;`;
  await conn.tooling.executeAnonymous(updateSubscriptionLine);
  await commonPage.open(`/lightning/r/OrderApi__Subscription_Line__c/${subscriptionLineId}/view`);
  await subscriptionLinePage.waitForPresence(await subscriptionLinePage.header);
  await commonPage.click(await commonPage.edit);
  await commonPage.click(await commonPage.save);
  await commonPage.waitForAjaxCall();
  expect(await commonPage.isDisplayed(await commonPage.cancel)).toBe(false);
});
