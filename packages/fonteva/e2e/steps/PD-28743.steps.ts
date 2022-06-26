import { Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { communitySitePage } from '../../pages/salesforce/community-site.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { commonPortalPage } from '../../pages/portal/common.page';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import * as data from '../data/PD-28743.json';

Before({ tags: '@TEST_PD-28932' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User fill multi-entry form page', async () => {
  const url = (await conn.query(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`)).records[0]
    .LTE__Site_URL__c;
  const multiEntryFormId = (await conn.query(`SELECT Id FROM PagesApi__Form__c WHERE Name = 'AutoMultiEntryForm'`))
    .records[0].Id;
  expect(await portalLoginPage.isDisplayed(await commonPortalPage.linkStore)).toEqual(true);
  await communitySitePage.open(`${url}${data.communityFormsPageUrl}${multiEntryFormId}`);
  await formPage.fillMultiEntryFormEmail(data.multiEntryFormEmail);
  await formPage.waitForAbsence(await formPage.multiEntryModal);
  expect(await formPage.multiEntryModal.isDisplayed()).toEqual(false);
});
