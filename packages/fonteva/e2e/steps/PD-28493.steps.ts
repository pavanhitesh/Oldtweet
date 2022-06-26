import * as faker from 'faker';
import { Before, Then } from '@cucumber/cucumber';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { documentPage } from '../../pages/salesforce/document.page';
import { conn } from '../../shared/helpers/force.helper';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

Before({ tags: '@TEST_PD-28941' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User exits to sales order and verifies the subTotal and Total amount in view document', async () => {
  await proformaInvoicePage.type(await proformaInvoicePage.sendTo, `${faker.name.firstName()}@mailinator.com`);
  await proformaInvoicePage.click(await proformaInvoicePage.sendEmail);
  await proformaInvoicePage.waitForPresence(await proformaInvoicePage.emailSentSuccessMessage);
  expect(await proformaInvoicePage.getText(await proformaInvoicePage.emailSentSuccessMessage)).toContain(
    'Your Email Has Been Sent.',
  );
  await proformaInvoicePage.click(await proformaInvoicePage.closeButton);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  const salesOrderResponse = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Subtotal__c, OrderApi__Total__c FROM OrderApi__Sales_Order__c where Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  await salesOrderPage.click(await salesOrderPage.viewDocument);
  await salesOrderPage.sleep(MilliSeconds.M);
  const allWindows: Array<string> = await browser.getWindowHandles();
  await browser.switchToWindow(allWindows[1]);
  const temp = (await browser.getUrl()).split('?doc=');
  const decodeUrl = decodeURIComponent(temp[temp.length - 1]);
  await documentPage.navigateTo(decodeUrl);
  await documentPage.waitForPresence(await documentPage.subTotalValue);
  expect(await (await documentPage.getText(await documentPage.subTotalValue)).split('$')[1]).toEqual(
    Number(salesOrderResponse.OrderApi__Subtotal__c).toFixed(2),
  );
  expect(await (await documentPage.getText(await documentPage.subTotalValue)).split('$')[1]).toEqual(
    Number(salesOrderResponse.OrderApi__Subtotal__c).toFixed(2),
  );
});
