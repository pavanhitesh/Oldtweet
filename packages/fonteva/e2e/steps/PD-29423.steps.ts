import { Before, Then, When } from '@cucumber/cucumber';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { createInvoicePage } from '../../pages/salesforce/create-Invoice.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29543' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

When(
  'User selects {string} as payment method, select payment term as {string} and proceeds further',
  async (paymentType, paymentTerm) => {
    localSharedData.paymentTerm = paymentTerm;
    await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther(paymentType);
    await createInvoicePage.click(await createInvoicePage.clearSearch);
    await createInvoicePage.waitForPresence(await createInvoicePage.paymentTermTextBox);
    await createInvoicePage.click(await createInvoicePage.paymentTermTextBox);
    await createInvoicePage.slowTypeFlex(await createInvoicePage.paymentTermTextBox, paymentTerm);
    await browser.keys(['Enter']);
    await createInvoicePage.click(await createInvoicePage.readyForPaymentButton);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  },
);

Then('User verifies due to date on the sales order is populated with Invoice Date plus Payment Term', async () => {
  const soDueDate = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `select OrderApi__Due_Date__c from OrderApi__Sales_Order__c where Name='${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Due_Date__c;

  const exDueDate: Date = new Date();
  if (localSharedData.paymentTerm === 'NET30') {
    exDueDate.setDate(exDueDate.getDate() + 30);
    expect(soDueDate).toEqual(exDueDate.toISOString().substring(0, 10));
  } else if (localSharedData.paymentTerm === 'NET15') {
    exDueDate.setDate(exDueDate.getDate() + 15);
    expect(soDueDate).toEqual(exDueDate.toISOString().substring(0, 10));
  } else {
    expect(soDueDate).toEqual(exDueDate.toISOString().substring(0, 10));
  }
});
