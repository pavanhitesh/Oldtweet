import { After, Then } from '@cucumber/cucumber';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$PagesApi__Form_Response__c, Fields$PagesApi__Field_Response__c } from '../../fonteva-schema';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';

Then(
  'User submits the created form and validates the response when IsRequired is {string} and value is {string}',
  async (isRequired: string, value: string) => {
    formPage.formButton = `${await browser.sharedStore.get('formFieldTypes')}`;
    if (value !== 'No') {
      const multipicklistValues = value.split(',');
      for (let i = 0; i < multipicklistValues.length; i += 1) {
        await formPage.click(await formPage.formButtonDetails);
        formPage.multiPicklistOption = multipicklistValues[i];
        await formPage.click(await formPage.multiPicklistOptions);
      }
    }
    await formPage.click(await formPage.submit);
    await formPage.waitForPresence(await formPage.name);
    if (isRequired === 'true' && value === 'No') {
      formPage.error = `${await browser.sharedStore.get('formFieldNames')}`;
      expect(await formPage.getText(await formPage.errorMessage)).toEqual(
        `${await browser.sharedStore.get('formFieldNames')}`.concat(` is required`),
      );
      const formResponseRecords = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
            'formId',
          )}'`,
        )
      ).records;
      expect(formResponseRecords.length).toEqual(0);
    } else if (isRequired === 'false' && value === 'No') {
      const formResponseId = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
            'formId',
          )}'`,
        )
      ).records[0].Id;
      const formFieldResponses = (
        await conn.query<Fields$PagesApi__Field_Response__c>(
          `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}' ORDER BY PagesApi__Form_Response__c`,
        )
      ).records[0].PagesApi__Response__c;
      expect(formFieldResponses).toEqual(null);
    } else {
      const formResponseId = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
            'formId',
          )}'`,
        )
      ).records[0].Id;
      const formFieldResponses = (
        await conn.query<Fields$PagesApi__Field_Response__c>(
          `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}' ORDER BY PagesApi__Form_Response__c`,
        )
      ).records[0].PagesApi__Response__c;
      expect(formFieldResponses).toEqual(value);
    }
  },
);

After({ tags: '@TEST_PD-29694' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Id = '${await browser.sharedStore.get(
    'formId',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
