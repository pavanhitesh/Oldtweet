import { Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { contactPage } from '../../pages/salesforce/contact.page';
import * as data from '../data/PD-27743.json';
import { orderPage } from '../../pages/portal/orders.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@REQ_PD-27743' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
  contactPage.deleteKnownAddress(data.contactName);
});

Then(
  'User verifies Address is optional text is not displayed for Billing Address and Process Payment button is not enabled',
  async () => {
    await orderPage.sleep(MilliSeconds.XXS);
    await expect(await applyPaymentPage.optionalAddressText.isDisplayed()).toEqual(false);
    await expect(await applyPaymentPage.textForNoAddress.isDisplayed()).toEqual(true);
    await expect(await applyPaymentPage.processPayment.isEnabled()).toEqual(false);
  },
);

Then('User selects {string} from Advanced Settings', async (businessGroup: string) => {
  localSharedData.businessGroup = businessGroup;
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.advancedSettings);
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.businessGroup);
  await rapidOrderEntryPage.selectByVisibleText(await rapidOrderEntryPage.businessGroup, businessGroup);
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.saveAdvancedSettings);
  expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.itemQuickAddTextBox)).toBe(true);
});

Then('User selects {string} payment on apply payment page', async (paymentType: string) => {
  expect(await applyPaymentPage.getText(await applyPaymentPage.businessGroupName)).toEqual(
    localSharedData.businessGroup,
  );
  await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentType);
  await applyPaymentPage.clickApplyPayments();
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.processPayment)).toEqual(true);
});
