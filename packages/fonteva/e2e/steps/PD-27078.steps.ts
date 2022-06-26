import { Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

Before({ tags: '@TEST_PD-27737' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should be able to process refund successfully', async () => {
  await receiptPage.click(await receiptPage.createRefund);
  await receiptPage.waitForPresence(await receiptPage.buttonProcessRefund);
  await receiptPage.click(await receiptPage.buttonProcessRefund);
  await receiptPage.waitForPresence(await receiptPage.refundConfirmation);
  expect(await receiptPage.isDisplayed(await receiptPage.refundConfirmation)).toEqual(true);
});
