/* eslint-disable @typescript-eslint/no-explicit-any */
import { Then, Before, After } from '@cucumber/cucumber';
import math = require('mathjs');
import { additionalItemsPage } from '../../pages/portal/additional-items.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';
import {
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Package_Item__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-28907' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User adds {string} item as included item to {string} item', async (includedItem: string, Item: string) => {
  state.ItemId = (await conn.query<Fields$OrderApi__Item__c>(`SELECT Id FROM OrderApi__Item__c WHERE Name = '${Item}'`))
    .records[0].Id as string;

  state.includedItem1Name = includedItem;

  state.includedItem1Id = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT Id FROM OrderApi__Item__c WHERE Name = '${state.includedItem1Name}'`,
    )
  ).records[0].Id as string;
  const addIncludedItem1: any = await conn.create('OrderApi__Package_Item__c', [
    {
      OrderApi__Item__c: `${state.includedItem1Id}`,
      OrderApi__Package__c: `${state.ItemId}`,
      OrderApi__Minimum_Quantity__c: 1,
      OrderApi__Maximum_Quantity__c: 1,
      OrderApi__Is_Required__c: true,
      OrderApi__Display_Item__c: true,
    },
  ]);
  expect(addIncludedItem1[0].success).toEqual(true);
});

Then('User verifies the {string} subscription lines is created after {string}', async (count: string, type: string) => {
  await loginPage.sleep(MilliSeconds.XXS);
  if (type === 'payment') {
    state.salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0].OrderApi__Sales_Order__c as string;
  } else {
    state.salesOrderId = (await browser.sharedStore.get('portalSO')) as string;
  }
  state.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;

  const subscriptionLineInfo = await conn.query(
    `SELECT OrderApi__Item__r.Name from OrderApi__Subscription_Line__c where OrderApi__Subscription__c= '${state.subscriptionId}'`,
  );
  expect(await subscriptionLineInfo.records.length).toEqual(math.number(count));
  expect(await subscriptionLineInfo.records[0].OrderApi__Item__r.Name).toEqual('ParentSubscriptionItem');
  if (type === 'payment') {
    expect(await subscriptionLineInfo.records[1].OrderApi__Item__r.Name).toEqual('IncludedItem1');
    expect(await subscriptionLineInfo.records[2].OrderApi__Item__r.Name).toEqual('AdditionalItem1');
  } else {
    expect(await subscriptionLineInfo.records[4].OrderApi__Item__r.Name).toEqual('IncludedItem2');
    expect(await subscriptionLineInfo.records[5].OrderApi__Item__r.Name).toEqual('AdditionalItem2');
  }
});

Then(
  'User removes included item and adds {string} item and {string} item on backend',
  async (includedItem2: string, additionalItem2: string) => {
    await conn.tooling.executeAnonymous(
      `DELETE [SELECT Id From OrderApi__Package_Item__c WHERE OrderApi__Item__r.Name = '${state.includedItem1Name}'];`,
    );

    state.includedItem2Id = (
      await conn.query<Fields$OrderApi__Item__c>(`SELECT Id FROM OrderApi__Item__c WHERE Name = '${includedItem2}'`)
    ).records[0].Id as string;

    state.additionalItem2Id = (
      await conn.query<Fields$OrderApi__Item__c>(`SELECT Id FROM OrderApi__Item__c WHERE Name = '${additionalItem2}'`)
    ).records[0].Id as string;

    const packageItemId = (
      await conn.query<Fields$OrderApi__Package_Item__c>(
        `SELECT Id FROM OrderApi__Package_Item__c WHERE OrderApi__Package__c = '${state.ItemId}' and OrderApi__Group_Header__c = 'Additional Items'`,
      )
    ).records[0].Id as string;

    const addIncludedItem2: any = await conn.create('OrderApi__Package_Item__c', [
      {
        OrderApi__Item__c: `${state.includedItem2Id}`,
        OrderApi__Package__c: `${state.ItemId}`,
        OrderApi__Minimum_Quantity__c: 1,
        OrderApi__Maximum_Quantity__c: 1,
        OrderApi__Is_Required__c: true,
        OrderApi__Display_Item__c: true,
      },
    ]);
    expect(addIncludedItem2[0].success).toEqual(true);
    state.addIncludedItem2Id = addIncludedItem2[0].id as string;

    const addAdditionalItem2: any = await conn.create('OrderApi__Package_Item__c', [
      {
        OrderApi__Item__c: `${state.additionalItem2Id}`,
        OrderApi__Package__c: `${state.ItemId}`,
        OrderApi__Package_Item__c: `${packageItemId}`,
        OrderApi__Minimum_Quantity__c: 1,
        OrderApi__Display_Item__c: true,
      },
    ]);
    expect(addAdditionalItem2[0].success).toEqual(true);
    state.addAdditionalItem2Id = addAdditionalItem2[0].id as string;
  },
);

Then(
  'User removes {string} item and select {string} item',
  async (additionalItem1: string, additionalItem2: string) => {
    await additionalItemsPage.waitForClickable(await additionalItemsPage.continue);
    additionalItemsPage.singleAdditionalItem = additionalItem1;
    await additionalItemsPage.click(await additionalItemsPage.selectAdditionalItem);
    additionalItemsPage.singleAdditionalItem = additionalItem2;
    await additionalItemsPage.click(await additionalItemsPage.selectAdditionalItem);
    await additionalItemsPage.click(await additionalItemsPage.continue);
    await additionalItemsPage.waitForAbsence(await additionalItemsPage.continue);
    expect(await additionalItemsPage.continue.isDisplayed()).toBe(false);
    await assignMemberPage.click(await assignMemberPage.AddToCart);
    await assignMemberPage.waitForAbsence(await assignMemberPage.AddToCart);
    expect(await assignMemberPage.AddToCart.isDisplayed()).toBe(false);
  },
);

After({ tags: '@TEST_PD-28907' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
  const deleteIncludedItem2 = await conn
    .sobject('OrderApi__Package_Item__c')
    .destroy(state.addIncludedItem2Id as string);
  expect(deleteIncludedItem2.success).toEqual(true);
  const deleteAdditionalItem2 = await conn
    .sobject('OrderApi__Package_Item__c')
    .destroy(state.addAdditionalItem2Id as string);
  expect(deleteAdditionalItem2.success).toEqual(true);
});
