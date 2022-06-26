import { After, Then } from '@cucumber/cucumber';
import { portalLoginPage } from '../../pages/portal/login.page';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';
import { commonPortalPage } from '../../pages/portal/common.page';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';

Then(
  'User fills {string} and submits the created form and validates the response when isRequired option is {string}',
  async (employeesInput: string, isRequiredStatus: string) => {
    formPage.inputForAccount = `${await browser.sharedStore.get('formFieldNames')}`;
    expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
    if (isRequiredStatus === 'true') {
      await formPage.type(await formPage.inputforAccountDetails, employeesInput);
      expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual('');
      await formPage.waitForPresence(await formPage.submit);
      await formPage.click(await formPage.submit);
      await formPage.waitForPresence(await formPage.name);
      formPage.error = `${await browser.sharedStore.get('formFieldNames')}`;
      const errorMessage = await formPage.getText(await formPage.errorMessage);
      const formResponseRecords = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${await browser.sharedStore.get(
            'formName',
          )}'`,
        )
      ).records;
      expect(formResponseRecords.length).toEqual(0);
      expect(errorMessage).toBe(`${await browser.sharedStore.get('formFieldNames')} is required`);
    } else {
      await formPage.type(await formPage.inputforAccountDetails, employeesInput);
      const numRegex = new RegExp('^([0-9])$');
      if (numRegex.test(employeesInput)) {
        expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(employeesInput);
        await formPage.waitForPresence(await formPage.submit);
        await formPage.click(await formPage.submit);
        await formPage.waitForPresence(await formPage.name);
        const formResponseId = (
          await conn.query<Fields$PagesApi__Form_Response__c>(
            `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${await browser.sharedStore.get(
              'formName',
            )}'`,
          )
        ).records[0].Id;
        const formFieldResponse = (
          await conn.query<Fields$PagesApi__Field_Response__c>(
            `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}'`,
          )
        ).records[0].PagesApi__Response__c;
        expect(formFieldResponse).toEqual(employeesInput);
      } else {
        expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual('');
        await formPage.waitForPresence(await formPage.submit);
        await formPage.click(await formPage.submit);
        await formPage.waitForPresence(await formPage.name);
        const formResponseId = (
          await conn.query<Fields$PagesApi__Form_Response__c>(
            `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${await browser.sharedStore.get(
              'formName',
            )}'`,
          )
        ).records[0].Id;
        const formFieldResponse = (
          await conn.query<Fields$PagesApi__Field_Response__c>(
            `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}'`,
          )
        ).records[0].PagesApi__Response__c;
        expect(formFieldResponse).toEqual(null);
      }
    }
  },
);

After({ tags: '@TEST_PD-29702' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
