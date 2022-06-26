import { Before, Then } from '@cucumber/cucumber';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';

Before({ tags: '@TEST_PD-28942' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User exits to sales order and verifies the sales order line is created with tax and shipping item {string}',
  async (itemName: string) => {
    await proformaInvoicePage.exitToSalesOrder();
    expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
    const soNumber = await salesOrderPage.getText(await salesOrderPage.salesOrderNumber);
    const records = (
      await conn.query(
        `SELECT OrderApi__Item__r.Name from OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__r.Name = '${soNumber}' and OrderApi__Item__r.Name = '${itemName}'`,
      )
    ).records[0].OrderApi__Item__r.Name;
    expect(records).toEqual(itemName);
  },
);
