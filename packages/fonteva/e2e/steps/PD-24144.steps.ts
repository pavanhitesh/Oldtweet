import { After, Before, Then } from '@cucumber/cucumber';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-27062' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27062' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${localSharedData.soNumber}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then('User exits to sales order and verifies the sales order is marked as proforma order', async () => {
  await proformaInvoicePage.exitToSalesOrder();
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  localSharedData.soNumber = await salesOrderPage.getText(await salesOrderPage.salesOrderNumber);
  const { records } = await conn.query(
    `SELECT OrderApi__Is_Proforma__c FROM OrderApi__Sales_Order__c WHERE Name = '${localSharedData.soNumber}'`,
  );
  expect(await records[0].OrderApi__Is_Proforma__c).toBe(true);
});
