import { Before, Then } from '@cucumber/cucumber';
import { communitySitePage } from '../../pages/salesforce/community-site.page';
import { loginPage } from '../../pages/salesforce/login.page';
import * as data from '../data/PD-28856.json';

Before({ tags: '@TEST_PD-28857' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User navigates to community sites page', async () => {
  await communitySitePage.open(`/lightning/o/LTE__Site__c/list`);
  await communitySitePage.waitForPresence(await communitySitePage.new);
  expect(await communitySitePage.isDisplayed(await communitySitePage.new)).toEqual(true);
});

Then('User clicks new Community Site and verifies the validation message', async () => {
  await communitySitePage.click(await communitySitePage.new);
  await communitySitePage.waitForPresence(await communitySitePage.siteCreationValidation);
  expect(await communitySitePage.getText(await communitySitePage.siteCreationValidation)).toEqual(
    data.validationMessage,
  );
});
