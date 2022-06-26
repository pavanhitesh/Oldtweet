import { Before, When, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { priceRulePage } from '../../pages/salesforce/price-rule.page';

Before({ tags: '@TEST_PD-27754' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

When(`User enters Start and End Dates for the Price rule using Calendar Picklist and saves`, async () => {
  // start date
  await priceRulePage.click(await priceRulePage.priceRuleStartDateCalendarIcon);
  await priceRulePage.waitForPresence(await priceRulePage.yearSelectionInCalendar);
  const dateVal = new Date();
  await priceRulePage.selectDateUsingCalendar(
    dateVal.toLocaleString('default', { month: 'long' }),
    dateVal.getDate() as unknown as string,
    dateVal.getFullYear() as unknown as string,
  );

  // end date
  await priceRulePage.click(await priceRulePage.priceRuleEndDateCalendarIcon);
  await priceRulePage.waitForPresence(await priceRulePage.yearSelectionInCalendar);
  await priceRulePage.selectDateUsingCalendar(
    dateVal.toLocaleString('default', { month: 'long' }),
    (dateVal.getDate() + 2) as unknown as string,
    dateVal.getFullYear() as unknown as string,
  );

  await priceRulePage.click(await priceRulePage.save);
  await priceRulePage.waitForAjaxCall();
  expect(await priceRulePage.priceRuleStartDate.getValue()).not.toBe('');
  expect(await priceRulePage.priceRuleEndDate.getValue()).not.toBe('');
});

Then(`User verifies manual updates on the start and End Dates fields are Saved and updated`, async () => {
  const updatedStartDate = await priceRulePage.getDate('MM/dd/yyyy', 1, 3, 1);
  const updatedEndDate = await priceRulePage.getDate('MM/dd/yyyy', 1, 5, 1);
  await priceRulePage.type(await priceRulePage.priceRuleStartDate, updatedStartDate);
  await priceRulePage.type(await priceRulePage.priceRuleEndDate, updatedEndDate);
  await priceRulePage.click(await priceRulePage.save);
  await priceRulePage.waitForAjaxCall();
  expect(await (await priceRulePage.priceRuleStartDate).getValue()).toContain(updatedStartDate);
  expect(await (await priceRulePage.priceRuleEndDate).getValue()).toContain(updatedEndDate);
});
