import { After, Then } from '@cucumber/cucumber';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from 'packages/fonteva/fonteva-schema';
import format from 'date-fns/format';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';

Then('User verifies Date value is empty by default', async () => {
  formPage.birthDate = `${await browser.sharedStore.get('formFieldTypes')}`;
  await formPage.waitForPresence(await formPage.birthDateDetails);
  expect(await formPage.getTextUsingJS(await formPage.birthDateDetails)).toEqual('');
});

Then(
  'User submits the form by entering Date value as {string} and validates the Response {string}',
  async (dateValue: string, errorNote: string) => {
    formPage.birthDate = `${await browser.sharedStore.get('formFieldTypes')}`;
    const isRequired = `${await browser.sharedStore.get('isRequired')}`;
    if (dateValue === 'valid') {
      const birthDate = await formPage.getDate('MM/dd/yyyy', 0, 0, 0);
      await formPage.waitForPresence(await formPage.birthDateDetails);
      await formPage.type(await formPage.birthDateDetails, birthDate);
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

      const formFieldResponse = (
        await conn.query<Fields$PagesApi__Field_Response__c>(
          `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formId}'`,
        )
      ).records[0].PagesApi__Response__c;

      expect(format(new Date(String(formFieldResponse)), 'MM/dd/yyyy')).toEqual(birthDate);
    } else if (isRequired === 'false' && dateValue !== 'NA') {
      await formPage.waitForPresence(await formPage.birthDateDetails);
      await formPage.type(await formPage.birthDateDetails, dateValue);
      await formPage.sleep(MilliSeconds.XS);
      formPage.dateError = `${await browser.sharedStore.get('formFieldNames')}`;
      expect(await formPage.getText(await formPage.errorMessage)).toEqual(errorNote);
    } else if (isRequired === 'false' && dateValue === 'NA') {
      await formPage.waitForPresence(await formPage.birthDateDetails);
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

      const formFieldResponse = (
        await conn.query<Fields$PagesApi__Field_Response__c>(
          `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formId}'`,
        )
      ).records[0].PagesApi__Response__c;

      expect(formFieldResponse).toBeNull();
    }
  },
);

After({ tags: '@TEST_PD-29709' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
