/* eslint-disable @typescript-eslint/no-explicit-any */
import { Then, Before, After, DataTable } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$OrderApi__Item__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';

Before({ tags: '@TEST_PD-29549' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29549' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('SalesOrderId')) as string);
  expect(deleteSO.success).toEqual(true);
});

Then(`User creates salesOrder lines with information provided below:`, async (solDataTable: DataTable) => {
  const salesOrderLineIds: string[] = [];
  const solDataRecords = solDataTable.hashes();
  await solDataRecords.reduce(async (memo, solData) => {
    await memo;
    const salesOrderId = await browser.sharedStore.get('SalesOrderId');
    const itemId = (
      await conn.query<Fields$OrderApi__Item__c>(`SELECT Id from OrderApi__Item__c WHERE NAME = '${solData.ItemName}'`)
    ).records[0].Id;
    const solCreationResponse = (
      await conn.apex.post<any>('/services/apexrest/FDService/OrderService', {
        id: salesOrderId,
        lines: [
          {
            item: itemId,
            salesOrder: salesOrderId,
            quantity: solData.Qty,
            isAdjustment: true,
          },
        ],
      })
    ).data;
    expect(await solCreationResponse.lines[0].salesOrder).not.toBe('');
    salesOrderLineIds.push(await solCreationResponse.lines[0].id);
  }, undefined);
  await browser.sharedStore.set('salesOrderLineIds', salesOrderLineIds);
});

Then(`User posts the SalesOrderline created`, async () => {
  const salesOrderLinesList = (await browser.sharedStore.get('salesOrderLineIds')) as string[];
  for (let i = 0; i < salesOrderLinesList.length; i += 1) {
    const solUpdateResponse = await conn.tooling.executeAnonymous(`
      OrderApi__Sales_Order_Line__c solData = [Select OrderApi__Is_Line_Posted__c from OrderApi__Sales_Order_Line__c Where Id = '${salesOrderLinesList[i]}'];
      solData.OrderApi__Is_Line_Posted__c = true;
      update solData;`);
    expect(solUpdateResponse.success).toEqual(true);
  }
});

Then(
  `User verifies there is no change in Adjustment and SO overall Total and Balance due is updated as per adjustment created`,
  async () => {
    const soData = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Balance_Due__c, OrderApi__Credits_and_Adjustments__c, OrderApi__Overall_Total__c FROM OrderApi__Sales_Order__c WHERE Id = '${await browser.sharedStore.get(
          'SalesOrderId',
        )}'`,
      )
    ).records[0];

    expect(soData.OrderApi__Credits_and_Adjustments__c).toEqual(0);

    const solData = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Overall_Total__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'SalesOrderId',
        )}'`,
      )
    ).records;

    expect(solData.length).toEqual(2);

    const solOverallTotal =
      (solData[0].OrderApi__Overall_Total__c as number) + (solData[1].OrderApi__Overall_Total__c as number);

    expect(solOverallTotal).toEqual(soData.OrderApi__Overall_Total__c);
    expect(solOverallTotal).toEqual(soData.OrderApi__Balance_Due__c);
  },
);
