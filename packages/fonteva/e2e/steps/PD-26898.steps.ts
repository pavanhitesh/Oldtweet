import { Given, Then, Before } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { orderPage } from '../../pages/portal/orders.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

let salesOrderId = '';

Before({ tags: '@TEST_PD-27605' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(
  'User create a Sales Order {string} from ROE and update IsProforma and IsCancelled as true',
  async (itemName: string) => {
    await rapidOrderEntryPage.addItemToOrder(itemName);
    expect(await rapidOrderEntryPage.verifyItemAddedToOrder(itemName)).toBe(true);
    await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther('Proforma Invoice');
    await proformaInvoicePage.waitForPresence(await proformaInvoicePage.exitButton);
    await proformaInvoicePage.exitToSalesOrder();
    salesOrderId = await salesOrderPage.getSalesOrderId();
    const url = await salesOrderPage.getUrl();
    const salesOrderid = url.split('/')[6];
    const apexBody = `OrderApi__Sales_Order__c so = [Select Id ,OrderApi__Is_Proforma__c from OrderApi__Sales_Order__c Where Id = '${salesOrderid}'];
    so.OrderApi__Is_Proforma__c = true;
    so.OrderApi__Is_Cancelled__c = true;
    update SO;`;
    await conn.tooling.executeAnonymous(apexBody);
  },
);

Then(
  'User Navigated to Order Page and valiadate the Cancelled Sales Order are not displayed under Open Order Tab',
  async () => {
    await commonPortalPage.openOrderLinks();
    const list = await orderPage.getSalesOrderList();
    expect(list).not.toHaveValueContaining(salesOrderId);
  },
);

Then('User Validates Cancelled Sales Orders are not present under All Orders Tab', async () => {
  await orderPage.clickAllOrdersTab();
  const list = await orderPage.getSalesOrderList();
  expect(list).not.toHaveValueContaining(salesOrderId);
});
