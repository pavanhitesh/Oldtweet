/* eslint-disable @typescript-eslint/no-explicit-any */
import { Given, DataTable, Then, Before, When, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$Contact,
  Fields$OrderApi__Credit_Memo__c,
  Fields$OrderApi__GL_Account__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Transaction_Line__c,
} from '../../fonteva-schema';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { loginPage } from '../../pages/salesforce/login.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29059' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(`User Creates Credit Memo line with below information`, async (creditMemoLine: DataTable) => {
  const creditMemoLineData = creditMemoLine.hashes();
  await creditMemoLineData.reduce(async (memo, memoData) => {
    await memo;
    const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${memoData.Contact}'`))
      .records[0].Id;

    localSharedData.creditMemoId = (
      await conn.query<Fields$OrderApi__Credit_Memo__c>(
        `SELECT Id FROM OrderApi__Credit_Memo__c WHERE OrderApi__Contact__c = '${contactId}'`,
      )
    ).records[0].Id;

    const glAcctId = (
      await conn.query<Fields$OrderApi__GL_Account__c>(
        `SELECT Id FROM OrderApi__GL_Account__c WHERE Name = '${memoData.LiabilityAccount}'`,
      )
    ).records[0].Id;

    const salesOrderLineId = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
      )
    ).records[0].Id;

    const creditMemoLineCreationData = {
      OrderApi__Amount__c: memoData.Amount,
      OrderApi__Credit_Account__c: glAcctId,
      OrderApi__Sales_Order_Line__c: salesOrderLineId,
      OrderApi__Credit_Memo__c: localSharedData.creditMemoId,
      OrderApi__Status__c: memoData.Status,
    };
    const creditMemoLineCreationResponse: any = await conn.create('OrderApi__Credit_Memo_Line__c', [
      creditMemoLineCreationData,
    ]);
    localSharedData.creditMemoLineId = creditMemoLineCreationResponse[0].id;
    expect(creditMemoLineCreationResponse[0].success).toBe(true);
  }, undefined);
});

Then(
  'User clicks on Exit button on rapid order entry and change Posting Entity to {string} and Schedule Type to {string}',
  async (postingEntity: string, scheduleType: string) => {
    const salesOrderNumbers: string[] = [];
    await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    localSharedData.salesOrderId = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
      )
    ).records[0].Id;
    salesOrderNumbers.push(await localSharedData.salesOrderId);
    await browser.sharedStore.set('salesOrderNumbers', salesOrderNumbers);
    const response = await conn.tooling.executeAnonymous(`
    OrderApi__Sales_Order__c SO = [Select OrderApi__Posting_Entity__c,OrderApi__Schedule_Type__c from OrderApi__Sales_Order__c Where Name = '${await browser.sharedStore.get(
      'SalesOrderNumber',
    )}'];
    SO.OrderApi__Posting_Entity__c = '${postingEntity}';
    SO.OrderApi__Schedule_Type__c = '${scheduleType}';
    update SO;`);
    expect(response.success).toEqual(true);
  },
);

When('User change the credit memo line status to Posted', async () => {
  const creditMemoLineStatusResponse = await conn.tooling.executeAnonymous(`
    OrderApi__Credit_Memo_Line__c creditMemoLine = [Select OrderApi__Status__c FROM OrderApi__Credit_Memo_Line__c Where Id = '${localSharedData.creditMemoLineId}'];
    creditMemoLine.OrderApi__Status__c = 'Posted';
    update creditMemoLine;`);
  expect(creditMemoLineStatusResponse.success).toEqual(true);
});

Then(
  'User Navigates to transaction lines in sales order and verifies Item is populated with {string}',
  async (item: string) => {
    const transactionLineItem = (
      await conn.query<Fields$OrderApi__Transaction_Line__c>(
        `SELECT OrderApi__Item__c from OrderApi__Transaction_Line__c where OrderApi__Transaction__c IN (SELECT Id FROM OrderApi__Transaction__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}')`,
      )
    ).records[0].OrderApi__Item__c;
    const itemID = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(`SELECT Id FROM OrderApi__Item__c WHERE Name = '${item}'`)
    ).records[0].Id;
    expect(transactionLineItem).toEqual(itemID);
  },
);

After({ tags: '@TEST_PD-29059' }, async () => {
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId);
  expect(deleteSO.success).toEqual(true);
});
