import { After, Then, When } from '@cucumber/cucumber';
import * as faker from 'faker';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';
import { portalLoginPage } from '../../pages/portal/login.page';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

When('User updates the form with Allow Multiple Entries as {string}', async (isEnabled: string) => {
  const isAllowRMultiEntry = await conn.tooling
    .executeAnonymous(`PagesApi__Field_Group__c isReq = [SELECT PagesApi__Is_Multiple__c FROM PagesApi__Field_Group__c WHERE Id = '${await browser.sharedStore.get(
    'groupIds',
  )}'];
  isReq.PagesApi__Is_Multiple__c = ${isEnabled};
  update isReq;`);
  expect(isAllowRMultiEntry.success).toEqual(true);
});

Then('User adds {int} entry values to form and submit and verify the Response', async (value: number) => {
  const entryNames: string[] = new Array(value);
  for (let i = 0; i < value - 1; i += 1) {
    entryNames[i] = faker.name.firstName();
    await formPage.waitForPresence(await formPage.newEntryButton);
    await formPage.click(await formPage.newEntryButton);
    await formPage.waitForPresence(await formPage.multiEntryModal);
    expect(await formPage.isDisplayed(await formPage.multiEntryModal)).toEqual(true);
    formPage.inputForContact = `${await browser.sharedStore.get('formFieldTypes')}`;
    await formPage.type(await formPage.inputforContactDetails, entryNames[i]);
    await formPage.click(await formPage.addEntryButton);
    await formPage.waitForPresence(await formPage.newEntryButton);
  }
  await formPage.waitForPresence(await formPage.submit);
  await formPage.click(await formPage.submit);
  await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
  await formPage.sleep(MilliSeconds.XS);

  const formId = (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records[0].Id;

  const formEnrtyResponse = await conn.query<Fields$PagesApi__Field_Response__c>(
    `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formId}'`,
  );

  for (let j = 0; j < value - 1; j += 1) {
    expect(formEnrtyResponse.records[j].PagesApi__Response__c).toEqual(entryNames[j]);
  }
});

After({ tags: '@TEST_PD-29807' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
