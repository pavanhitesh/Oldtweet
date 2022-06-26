import { After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';

After({ tags: '@TEST_PD-29650' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
