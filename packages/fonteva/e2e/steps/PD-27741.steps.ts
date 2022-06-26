/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Given, Then, DataTable } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28207' }, async () => {
  state.itemClassId = (await conn.query(`SELECT Id from OrderApi__Item_Class__c where Name = 'Merchandise Class'`))
    .records[0].Id as string;

  state.bussinessGroupId = (await conn.query(`SELECT Id from OrderApi__Business_Group__c where Name = 'Foundation'`))
    .records[0].Id as string;
});

After({ tags: '@TEST_PD-28207' }, async () => {
  const deleteCatalog = await conn.sobject('OrderApi__Catalog_Item__c').destroy(state.catalogId as string);
  expect(deleteCatalog.success).toEqual(true);
  const deleteItem = await conn.sobject('OrderApi__Item__c').destroy(state.itemId as string);
  expect(deleteItem.success).toEqual(true);
  const deleteSource = await conn.sobject('OrderApi__Source_Code__c').destroy(state.sourceCodeId as string);
  expect(deleteSource.success).toEqual(true);
  const deleteSalesOrder = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('portalSO')) as string,
  );
  expect(deleteSalesOrder.success).toEqual(true);
  await commonPortalPage.deleteAllCookies();
});

Given('User creates a item and adds to catalog', async (table: DataTable) => {
  const dataTable = table.hashes();
  const row = dataTable[0];
  const itemResponse: any = await conn.create('OrderApi__Item__c', [
    {
      Name: row.itemName as string,
      OrderApi__Business_Group__c: state.bussinessGroupId as string,
      OrderApi__Price__c: row.itemPrice,
      OrderApi__Item_Class__c: state.itemClassId as string,
      OrderApi__Is_Active__c: true,
    },
  ]);
  expect(itemResponse[0].success).toEqual(true);
  state.itemId = itemResponse[0].id as string;

  const catalogId = (await conn.query(`SELECT Id FROM OrderApi__Catalog__c WHERE Name = '${row.catalog}'`)).records[0]
    .Id;
  const catalogResponse: any = await conn.create('OrderApi__Catalog_Item__c', [
    {
      OrderApi__Catalog__c: catalogId,
      OrderApi__Item__c: state.itemId,
      OrderApi__Is_Published__c: true,
    },
  ]);
  expect(catalogResponse[0].success).toEqual(true);
  state.catalogId = catalogResponse[0].id as string;
});

Given('User configures source code price rule', async (table: DataTable) => {
  const dataTable = table.hashes();
  const row = dataTable[0];

  const sourceCodeResponse = await conn.create('OrderApi__Source_Code__c', {
    Name: row.sourceCode,
    OrderApi__Channel__c: 'Website',
    OrderApi__Active__c: true,
    OrderApi__Business_Group__c: state.bussinessGroupId,
  });
  expect(sourceCodeResponse.success).toEqual(true);
  state.sourceCodeId = sourceCodeResponse.id as string;

  const createPriceRule = `OrderApi__Price_Rule__c priceRule = new OrderApi__Price_Rule__c();
    priceRule.Name = '${row.ruleName}';
    priceRule.OrderApi__Item__c = '${state.itemId}';
    priceRule.OrderApi__Price__c = ${row.discountprice};
    priceRule.OrderApi__Is_Active__c = true;
    priceRule.OrderApi__Required_Source_Codes__c = '${state.sourceCodeId}';
    Insert priceRule;`;
  const response = await conn.tooling.executeAnonymous(createPriceRule);
  expect(response.success).toEqual(true);
});

Then(
  'User validates the apply button is clickable after applying discount code {string}',
  async (discountCode: string) => {
    await commonPortalPage.waitForPresence(await commonPortalPage.textBoxSourceCode);
    await commonPortalPage.type(await commonPortalPage.textBoxSourceCode, discountCode);
    expect(await commonPortalPage.isEnabled(await commonPortalPage.buttonApplySourceCode)).toEqual(true);
    expect(await commonPortalPage.isClickable(await commonPortalPage.buttonApplySourceCode)).toEqual(true);
  },
);
