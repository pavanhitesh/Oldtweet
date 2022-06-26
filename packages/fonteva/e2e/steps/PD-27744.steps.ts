/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Given, Then, DataTable } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';
import * as data from '../data/PD-27744.json';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28151' }, async () => {
  const recordsItemClass = (await conn.query(data.soql.itemClassId)).records[0];
  state.itemClassId = recordsItemClass.Id as string;
  const recordsbussinessGroup = (await conn.query(data.soql.bussinessGroupId)).records[0];
  state.bussinessGroupId = recordsbussinessGroup.Id as string;
});

After({ tags: '@TEST_PD-28151' }, async () => {
  const deleteCatalog = await conn.sobject('OrderApi__Catalog_Item__c').destroy(state.catalogId as string);
  expect(deleteCatalog.success).toEqual(true);
  const deleteItem = await conn.sobject('OrderApi__Item__c').destroy(state.itemId as string);
  expect(deleteItem.success).toEqual(true);
});

Given(
  'User creates a item to catalog and configure the price rule with start and past date with past date',
  async (table: DataTable) => {
    const dataTable = table.hashes();
    const row = dataTable[0];
    data.createItem.Name = row.itemName;
    data.createItem.OrderApi__Price__c = row.itemPrice;
    data.createItem.OrderApi__Business_Group__c = state.bussinessGroupId as string;
    data.createItem.OrderApi__Item_Class__c = state.itemClassId as string;
    const itemResponse: any = await conn.create('OrderApi__Item__c', [data.createItem]);
    state.itemId = itemResponse[0].id as string;
    const { records } = await conn.query(`SELECT Id FROM OrderApi__Catalog__c WHERE Name = '${row.catalog}'`);
    const { Id } = records[0];
    data.createCatalogItem.OrderApi__Catalog__c = Id as string;
    data.createCatalogItem.OrderApi__Item__c = state.itemId as string;
    const catalogResponse: any = await conn.create('OrderApi__Catalog_Item__c', [data.createCatalogItem]);
    state.catalogId = catalogResponse[0].id as string;
    const createItem = `OrderApi__Price_Rule__c priceRule = new OrderApi__Price_Rule__c();
    priceRule.Name = 'Sample Price Rule';
    priceRule.OrderApi__Item__c = '${state.itemId}';
    priceRule.OrderApi__Price__c = ${row.discountprice};
    priceRule.OrderApi__Is_Active__c = true;
    priceRule.OrderApi__Start_Date__c = date.parse('${await shoppingCartPage.getDate('MM/dd/yyyy', 0, -2)}');
    priceRule.OrderApi__End_Date__c = date.parse('${await shoppingCartPage.getDate('MM/dd/yyyy', 0, -1)}');
    Insert priceRule;`;
    const response = await conn.tooling.executeAnonymous(createItem);
    expect(response.success).toEqual(true);
  },
);

Then(
  'User Should navigate to store and add a item {string} and validate the price displayed for Item is {string}',
  async (itemName: string, price: string) => {
    await commonPortalPage.clickStore();
    await commonPortalPage.selectItem(itemName);
    expect(await shoppingCartPage.getText(await shoppingCartPage.itemPrice)).toEqual(price);
    await commonPortalPage.addToCart();
    expect(await commonPortalPage.isDisplayed(await commonPortalPage.imageCheckout)).toEqual(true);
  },
);

Then('User verifies the final amount {string} on the checkout page', async (price: string) => {
  await commonPortalPage.clickCheckoutbutton();
  expect(await checkoutPage.getText(await checkoutPage.totalCheckOutAmount)).toEqual(price);
});
