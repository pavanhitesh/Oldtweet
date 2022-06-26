import { Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { priceRulePage } from '../../pages/salesforce/price-rule.page';

Before({ tags: '@TEST_PD-27706' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(`User clicks on Price rule Cancel button to exit from price rule page`, async () => {
  await priceRulePage.click(await priceRulePage.cancel);
  await priceRulePage.waitForAjaxCall();
  await priceRulePage.waitForAbsence(await priceRulePage.cancel);
  expect(await priceRulePage.isDisplayed(await priceRulePage.cancel)).toBe(false);
});
