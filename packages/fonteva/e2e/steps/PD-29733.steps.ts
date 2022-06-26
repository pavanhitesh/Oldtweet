import { After, Then } from '@cucumber/cucumber';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { formPage } from '../../pages/portal/form.page';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';

Then(
  'User submits the created currency field form and validates the response when isRequired option is {string} and value is {string}',
  async (isRequiredStatus: string, CurrencyFieldValue: string) => {
    formPage.inputForAccount = `${await browser.sharedStore.get('formFieldNames')}`;
    await formPage.refreshBrowser();
    await formPage.waitForPresence(await formPage.submit);
    if (isRequiredStatus === 'true' && CurrencyFieldValue === 'NA') {
      await formPage.click(await formPage.submit);
      await formPage.waitForPresence(await formPage.name);
      expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
      formPage.error = `${await browser.sharedStore.get('formFieldNames')}`;
      const errorMessage = await formPage.getText(await formPage.errorMessage);
      const formResponseRecords = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
            'formId',
          )}'`,
        )
      ).records;
      expect(formResponseRecords.length).toEqual(0);
      expect(errorMessage).toBe(`${await browser.sharedStore.get('formFieldNames')} is required`);
    } else if (isRequiredStatus === 'false' && new RegExp(/^\d+(\.\d{1,2})?$/).test(CurrencyFieldValue)) {
      await formPage.type(await formPage.inputforAccountDetails, CurrencyFieldValue);
      await formPage.click(await formPage.submit);
      await formPage.waitForPresence(await formPage.name);
      expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
      await formPage.refreshBrowser();
      await formPage.waitForPresence(await formPage.submit);
      const formResponseId = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
            'formId',
          )}'`,
        )
      ).records[0].Id;
      const formFieldResponse = (
        await conn.query<Fields$PagesApi__Field_Response__c>(
          `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}'`,
        )
      ).records[0].PagesApi__Response__c;
      expect(formFieldResponse).toEqual(CurrencyFieldValue);
    } else {
      if (!(CurrencyFieldValue === 'NA')) {
        await formPage.type(await formPage.inputforAccountDetails, CurrencyFieldValue);
      }
      await formPage.click(await formPage.submit);
      await formPage.waitForPresence(await formPage.name);
      expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
      await formPage.refreshBrowser();
      await formPage.waitForPresence(await formPage.submit);
      const formResponseId = (
        await conn.query<Fields$PagesApi__Form_Response__c>(
          `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
            'formId',
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
  },
);

After({ tags: '@TEST_PD-29734' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Id = '${await browser.sharedStore.get(
    'formId',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
