import { After, Then } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

Then('User enter the Percent value {string} and Submit the form and verify response', async (percentValue: string) => {
  let errorNote = '';
  if (Number(percentValue) >= 100) {
    errorNote = 'This value should be lower than or equal to 100.';
  } else if (Number(percentValue) === 0) {
    errorNote = 'Percentage is required';
  } else if (Number(percentValue) <= 0) {
    errorNote = 'This value should be greater than or equal to 0.';
  } else {
    errorNote = '';
  }
  const fieldName = `${await browser.sharedStore.get('formFieldNames')}`;
  formPage.inputForAccount = fieldName;
  await formPage.waitForPresence(await formPage.inputforAccountDetails);
  await formPage.type(await formPage.inputforAccountDetails, percentValue);
  if (Number.isNaN(Number(percentValue))) {
    const getpercentValue = await formPage.getText(await formPage.inputforAccountDetails);
    expect(getpercentValue.length).toEqual(0);
  } else {
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.waitForPresence(await formPage.name);
    await formPage.sleep(MilliSeconds.XS);
    if (errorNote.length > 0) {
      formPage.error = fieldName;
      expect(await formPage.getText(await formPage.errorMessage)).toEqual(errorNote);
    } else {
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
      if (percentValue.length === 0) {
        expect(formFieldResponse).toEqual(null);
      } else {
        expect(formFieldResponse).toEqual(percentValue);
      }
    }
  }
});

After({ tags: '@TEST_PD-29717' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
