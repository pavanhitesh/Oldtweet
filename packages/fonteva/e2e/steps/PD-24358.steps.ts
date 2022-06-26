/* eslint-disable @typescript-eslint/no-explicit-any */
import { Before, Then, Given, DataTable, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28274' }, async () => {
  state.bussinessGroupId = (await conn.query(`SELECT Id from OrderApi__Business_Group__c where Name = 'Foundation'`))
    .records[0].Id as string;

  state.itemClassId = (await conn.query(`SELECT Id from OrderApi__Item_Class__c where Name = 'Subscription Class'`))
    .records[0].Id as string;

  state.badgeId = (await conn.query(`SELECT Id from OrderApi__Badge_Type__c where Name = 'Auto_MenuItem_Badge'`))
    .records[0].Id as string;

  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28274' }, async () => {
  const deletePackageItem = await conn.destroy('OrderApi__Package_Item__c', [
    state.mainPackagedId as string,
    state.packagedId as string,
  ]);
  expect(deletePackageItem[0].success).toEqual(true);
  expect(deletePackageItem[1].success).toEqual(true);

  const deleteSubscriptionPlan = await conn.destroy('OrderApi__Item_Subscription_Plan__c', [
    state.subscriptionId as string,
    state.itemsubscriptionId as string,
  ]);
  expect(deleteSubscriptionPlan[0].success).toEqual(true);
  expect(deleteSubscriptionPlan[1].success).toEqual(true);

  const deleteSubscription = await conn.destroy('OrderApi__Subscription_Plan__c', state.subscriptionPlanId as string);
  expect(deleteSubscription.success).toEqual(true);

  const deleteItem = await conn
    .sobject('OrderApi__Item__c')
    .destroy([state.itemId as string, state.subItemId as string]);
  expect(deleteItem[0].success).toEqual(true);
  expect(deleteItem[1].success).toEqual(true);
});

Given('User creates a sub packaged item and configure the price rule', async (data: DataTable) => {
  const dataTable = data.hashes();
  const row = dataTable[0];
  const itemResponse: any = await conn.create('OrderApi__Item__c', [
    {
      Name: row.subItemName,
      OrderApi__Business_Group__c: state.bussinessGroupId as string,
      OrderApi__Price__c: row.subItemPrice,
      OrderApi__Item_Class__c: state.itemClassId as string,
      OrderApi__Is_Active__c: false,
    },
  ]);
  expect(itemResponse[0].success).toEqual(true);
  state.subItemId = itemResponse[0].id as string;

  const createSubscriptionPlan: any = await conn.create('OrderApi__Subscription_Plan__c', {
    OrderApi__Is_Active__c: true,
    Name: 'CalenderTypeSubscription',
    OrderApi__Type__c: 'Calendar',
    OrderApi__Calendar_End_Month__c: '12 - December',
    OrderApi__Enable_Schedule__c: true,
    OrderApi__Schedule_Frequency__c: 'Monthly',
    OrderApi__Schedule_Type__c: 'Automatic Payment',
    OrderApi__Business_Group__c: state.bussinessGroupId as string,
  });
  expect(createSubscriptionPlan.success).toEqual(true);
  state.subscriptionPlanId = createSubscriptionPlan.id as string;

  const subscriptionResponse: any = await conn.create('OrderApi__Item_Subscription_Plan__c', {
    OrderApi__Is_Default__c: true,
    OrderApi__Item__c: state.subItemId,
    OrderApi__Subscription_Plan__c: state.subscriptionPlanId,
  });
  expect(subscriptionResponse.success).toEqual(true);
  state.subscriptionId = subscriptionResponse.id as string;

  const updateItemResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Item__c item = [Select Id from OrderApi__Item__c Where Id = '${state.subItemId}'];
  item.OrderApi__Is_Active__c = true;
  update item;`);
  expect(updateItemResponse.success).toEqual(true);

  const configurePriceRule = `OrderApi__Price_Rule__c priceRule = new OrderApi__Price_Rule__c();
    priceRule.Name = 'Sample Price Rule';
    priceRule.OrderApi__Item__c = '${state.subItemId}';
    priceRule.OrderApi__Price__c = ${parseInt(row.discountPrice.replace('$', ''), 10)};
    priceRule.OrderApi__Is_Active__c = true;
    priceRule.OrderApi__Required_Badge_Types__c = '${state.badgeId}';
    Insert priceRule;`;
  const response = await conn.tooling.executeAnonymous(configurePriceRule);
  expect(response.success).toEqual(true);
});

Given('User creates a packaged item with sub packaged item', async (data: DataTable) => {
  const dataTable = data.hashes();
  const row = dataTable[0];
  const itemResponse: any = await conn.create('OrderApi__Item__c', [
    {
      Name: row.PackageItemName,
      OrderApi__Business_Group__c: state.bussinessGroupId as string,
      OrderApi__Price__c: row.packagedItemPrice,
      OrderApi__Item_Class__c: state.itemClassId as string,
      OrderApi__Is_Active__c: false,
    },
  ]);
  expect(itemResponse[0].success).toEqual(true);
  state.itemId = itemResponse[0].id as string;

  const itemsubscriptionResponse: any = await conn.create('OrderApi__Item_Subscription_Plan__c', {
    OrderApi__Is_Default__c: true,
    OrderApi__Item__c: state.itemId,
    OrderApi__Subscription_Plan__c: state.subscriptionPlanId,
  });
  expect(itemsubscriptionResponse.success).toEqual(true);
  state.itemsubscriptionId = itemsubscriptionResponse.id as string;

  const updateItemResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Item__c SO = [Select Id from OrderApi__Item__c Where Id = '${state.itemId}'];
  SO.OrderApi__Is_Active__c = true;
  update SO;`);
  expect(updateItemResponse.success).toEqual(true);

  const packagedMainItem: any = await conn.create('OrderApi__Package_Item__c', {
    OrderApi__Package__c: state.itemId,
    OrderApi__Minimum_Quantity__c: 1,
    OrderApi__Maximum_Quantity__c: 1,
    OrderApi__Maximum_Quantity_Per_Item__c: 1,
  });
  expect(packagedMainItem.success).toEqual(true);
  state.mainPackagedId = packagedMainItem.id as string;

  const packagedItem = await conn.create('OrderApi__Package_Item__c', {
    OrderApi__Item__c: state.subItemId,
    OrderApi__Package__c: state.itemId,
    OrderApi__Minimum_Quantity__c: 1,
    OrderApi__Package_Item__c: state.mainPackagedId,
  });
  expect(packagedItem.success).toEqual(true);
  state.packagedId = packagedItem.id as string;
});

Then('User verifies Additional Package item price is displayed as {string}', async (price: string) => {
  expect(await rapidOrderEntryPage.getText(await rapidOrderEntryPage.optionalItemPriceText)).toEqual(price);
});
