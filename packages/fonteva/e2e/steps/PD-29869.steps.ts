import { After, Before, Then } from '@cucumber/cucumber';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-30037' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(`User verifies the Balance due, current due, payment and Remaining balance are populated properly`, async () => {
  const orderDetailsBalanceDue = await applyPaymentPage.getText(await applyPaymentPage.orderDetailsTableBalanceDue);
  const orderDetailsCurrentDue = await applyPaymentPage.getText(await applyPaymentPage.orderDetailsTableCurrentDue);
  const paymentApplied = await applyPaymentPage.getText(await applyPaymentPage.paymentsApplied);
  const remainingBalance = await applyPaymentPage.getText(await applyPaymentPage.remainingBalanceAmount);

  expect(orderDetailsBalanceDue).toBe(paymentApplied);
  expect(orderDetailsCurrentDue).toBe(paymentApplied);
  expect(remainingBalance).toBe('$0.00');
});

After({ tags: '@TEST_PD-30037' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('SalesOrderId')) as string);
  expect(deleteSO.success).toEqual(true);
});
