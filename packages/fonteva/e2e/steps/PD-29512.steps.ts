import { After, Before, Then } from '@cucumber/cucumber';
import { add, format } from 'date-fns';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { Fields$OrderApi__Payment_Terms__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@REQ_PD-29512' }, async () => {
  await loginPage.open('/');
  if ((await loginPage.isDisplayed(await loginPage.username)) === true) await loginPage.login();

  localSharedData.defaultPaymentTermVariable = (
    await conn.query<Fields$OrderApi__Payment_Terms__c>(`
  SELECT OrderApi__Variable__c FROM OrderApi__Payment_Terms__c WHERE Name = 'Due on Receipt' AND OrderApi__Business_Group__r.Name = 'Foundation'`)
  ).records[0].OrderApi__Variable__c;

  const termVariableUpdateResponse = await conn.tooling
    .executeAnonymous(`OrderApi__Payment_Terms__c defaultTerm = [SELECT OrderApi__Variable__c FROM OrderApi__Payment_Terms__c WHERE Name = 'Due on Receipt' AND OrderApi__Business_Group__r.Name = 'Foundation'];
  defaultTerm.OrderApi__Variable__c = 30;
  update defaultTerm;`);
  expect(termVariableUpdateResponse.success).toEqual(true);
});

After({ tags: '@REQ_PD-29512' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('SalesOrderId')) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);

  const termVariableUpdateRevertResponse = await conn.tooling
    .executeAnonymous(`OrderApi__Payment_Terms__c defaultTerm = [SELECT OrderApi__Variable__c FROM OrderApi__Payment_Terms__c WHERE Name = 'Due on Receipt' AND OrderApi__Business_Group__r.Name = 'Foundation'];
  defaultTerm.OrderApi__Variable__c = ${localSharedData.defaultPaymentTermVariable};
  update defaultTerm;`);
  expect(termVariableUpdateRevertResponse.success).toEqual(true);
});

Then('User exits to sales order page from {string} page', async (pageName: string) => {
  if (pageName === 'roe') await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
  else await applyPaymentPage.click(await applyPaymentPage.cancelButton);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
});

Then(`User converts the created sales order to Invoice and validates due date`, async () => {
  const receiptToInvoiceConversion = await conn.tooling.executeAnonymous(`
    OrderApi__Sales_Order__c SO = [Select OrderApi__Posting_Entity__c,OrderApi__Schedule_Type__c from OrderApi__Sales_Order__c Where Id = '${
      (await browser.sharedStore.get('SalesOrderId')) as string
    }'];
    SO.OrderApi__Posting_Entity__c = 'Invoice';
    SO.OrderApi__Schedule_Type__c = 'Simple Invoice';
    update SO;`);
  expect(receiptToInvoiceConversion.success).toEqual(true);

  const paymentTermVariable = (
    await conn.query<Fields$OrderApi__Payment_Terms__c>(`
  SELECT OrderApi__Variable__c FROM OrderApi__Payment_Terms__c WHERE Name = 'Due on Receipt' AND OrderApi__Business_Group__r.Name = 'Foundation'`)
  ).records[0].OrderApi__Variable__c;

  localSharedData.expectedSODueDate = format(add(new Date(), { days: paymentTermVariable as number }), 'yyyy-MM-dd');

  const actualSODueDate = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Due_Date__c FROM OrderApi__Sales_Order__c WHERE Id = '${await browser.sharedStore.get(
        'SalesOrderId',
      )}'`,
    )
  ).records[0].OrderApi__Due_Date__c;

  expect(localSharedData.expectedSODueDate).toEqual(actualSODueDate);
});

Then(`User makes the sales order Ready for payment and validates the due date`, async () => {
  await salesOrderPage.refreshBrowser();
  await salesOrderPage.waitForClickable(await salesOrderPage.readyForPayment);
  await salesOrderPage.click(await salesOrderPage.readyForPayment);
  await salesOrderPage.waitForClickable(await salesOrderPage.readyForPayment);

  const readyForPaymentSODueDate = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Due_Date__c FROM OrderApi__Sales_Order__c WHERE Id = '${await browser.sharedStore.get(
        'SalesOrderId',
      )}'`,
    )
  ).records[0].OrderApi__Due_Date__c;

  expect(readyForPaymentSODueDate).toEqual(localSharedData.expectedSODueDate);
});
