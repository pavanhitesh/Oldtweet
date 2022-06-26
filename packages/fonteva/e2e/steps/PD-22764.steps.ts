import { After, When } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { invoiceMe } from '../../pages/portal/invoice-me.page';
import { receiptPage } from '../../pages/portal/receipt.page';

After({ tags: '@TEST_PD-28830' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
});

When('User successfully pays for the order using Invoice Me', async () => {
  await invoiceMe.completeInvoiceMeTransaction();
  await receiptPage.waitForPresence(await receiptPage.invoiceConfirmationMessage);
  expect(await receiptPage.isDisplayed(await receiptPage.invoiceConfirmationMessage)).toBe(true);
});
