/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Given, When, DataTable } from '@cucumber/cucumber';
import { receiptPage } from '../../pages/portal/receipt.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import { Fields$OrderApi__Known_Address__c } from '../../fonteva-schema';
import { addressComponent } from '../../pages/portal/components/address.component';
import { portalLoginPage } from '../../pages/portal/login.page';
import * as data from '../data/PD-26896.json';

const state: { [key: string]: string } = {};

Before({ tags: '@REQ_PD-26896' }, async () => {
  const { records } = await conn.query(data.soql.itemClassId);
  const { Id } = records[0];
  state.itemClassId = Id as string;
});

After({ tags: '@REQ_PD-26896' }, async () => {
  const deletePriceRule = await conn.sobject('OrderApi__Price_Rule__c').destroy(state.priceRuleId as string);
  expect(deletePriceRule.success).toEqual(true);
  const deleteCatalog = await conn.sobject('OrderApi__Catalog_Item__c').destroy(state.catalogId as string);
  expect(deleteCatalog.success).toEqual(true);
  const deleteItem = await conn.sobject('OrderApi__Item__c').destroy(state.itemId as string);
  expect(deleteItem.success).toEqual(true);
  const deleteSource = await conn.sobject('OrderApi__Source_Code__c').destroy(state.sourceCodeId as string);
  expect(deleteSource.success).toEqual(true);
});

Given('User should removes the known address for the contact {string}', async (contactName: string) => {
  const result = await conn.query<Fields$OrderApi__Known_Address__c>(
    `SELECT Id FROM OrderApi__Known_Address__c WHERE OrderApi__Contact__c in (SELECT Id FROM Contact where Name = '${contactName}')`,
  );
  const knownAddressIdList = result.records.map((item) => item.Id);
  await conn.destroy('OrderApi__Known_Address__c', knownAddressIdList);
});

Given(
  'User should create a source code as {string} for channel {string}',
  async (sourcecode: string, channel: string) => {
    const { records } = await conn.query(data.soql.bussinessGroupId);
    const { Id } = records[0];
    state.bussinessGroupId = Id as string;
    data.createSourceCode.Name = sourcecode;
    data.createSourceCode.OrderApi__Business_Group__c = Id as string;
    data.createSourceCode.OrderApi__Channel__c = channel;
    const sourceCodeResponse = await conn.create('OrderApi__Source_Code__c', data.createSourceCode);
    state.sourceCodeId = sourceCodeResponse.id as string;
    expect(sourceCodeResponse.success).toEqual(true);
  },
);

Given('User should create a item {string} which is taxable', async (itemName: string) => {
  data.createItem.Name = itemName;
  data.createItem.OrderApi__Business_Group__c = state.bussinessGroupId as string;
  data.createItem.OrderApi__Item_Class__c = state.itemClassId as string;
  const { records } = await conn.query(data.soql.taxClassId);
  const { Id } = records[0];
  state.taxClassId = Id as string;
  data.createItem.OrderApi__Tax_Class__c = state.taxClassId as string;
  const itemResponse: any = await conn.create('OrderApi__Item__c', [data.createItem]);
  state.itemId = itemResponse[0].id as string;
  // expect(itemResponse.success).toEqual(true);
});

Given('User should add created item to catalogs {string}', async (catalog: string) => {
  const { records } = await conn.query(`SELECT Id FROM OrderApi__Catalog__c WHERE Name = '${catalog}'`);
  const { Id } = records[0];
  data.createCatalogItem.OrderApi__Catalog__c = Id as string;
  data.createCatalogItem.OrderApi__Item__c = state.itemId as string;
  const catalogResponse: any = await conn.create('OrderApi__Catalog_Item__c', [data.createCatalogItem]);
  // expect(catalogResponse.success).toEqual(true);
  state.catalogId = catalogResponse[0].id as string;
});

Given('User Should the price rule with following details', async (table: DataTable) => {
  const dataTable = table.hashes();
  const row = dataTable[0];
  data.managePriceRule.OrderApi__Item__c = state.itemId as string;
  data.managePriceRule.Name = row.Name;
  data.managePriceRule.OrderApi__Price__c = row.price;
  data.managePriceRule.OrderApi__Required_Source_Codes__c = state.sourceCodeId as string;
  const priceRuleResponse = await conn.create('OrderApi__Price_Rule__c', data.managePriceRule);
  state.priceRuleId = priceRuleResponse.id as string;
});

When(
  'User Should navigate to community portal with the created user {string} and password {string} as authenticated user',
  async (username: string, password: string) => {
    const url = (await conn.query(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`)).records;
    await portalLoginPage.openLT(`${url[0].LTE__Site_URL__c}`);
    await portalLoginPage.portalLogin(username, password);
    expect(await commonPortalPage.linkStore).toBeDisplayed();
  },
);

When('User Should navigate to store and add the item {string}', async (itemName: string) => {
  await commonPortalPage.clickStore();
  await commonPortalPage.selectItem(itemName);
  await commonPortalPage.addToCart();
  expect(await commonPortalPage.imageCheckout).toBeDisplayed();
});

When('User Should click on the checkout button', async () => {
  await commonPortalPage.clickCheckoutbutton();
  const orgId = await browser.sharedStore.get('organizationId');
  const cookie = JSON.parse(
    (await browser.getCookies([`apex__${orgId}-fonteva-community-shopping-cart`]))[0].value,
  ).salesOrderId;
  browser.sharedStore.set('portalSO', cookie);
  expect(await commonPortalPage.textBoxSourceCode.isDisplayed()).toBe(true);
});

When('User Should select the sourcecode {string}', async (sourcecode: string) => {
  await commonPortalPage.setDiscountCode(sourcecode);
  expect(await addressComponent.buttonCreateAddress).toBeDisplayed();
});

When(
  'User Should add the new address as name {string} , type {string} and address {string}',
  async (name: string, type: string, address: string) => {
    await addressComponent.addNewAddress(name, type, address);
    expect(await addressComponent.textCreatedAddress).toBePresent();
  },
);

When('User Should process the payment', async () => {
  if (await addressComponent.isDisplayed(await addressComponent.buttonContinue)) {
    await addressComponent.click(await addressComponent.buttonContinue);
  }
  await creditCardComponent.click(await creditCardComponent.buttonConfirmOrder);
  expect(await receiptPage.paymentConfirmationMessage).toBeDisplayed();
});
