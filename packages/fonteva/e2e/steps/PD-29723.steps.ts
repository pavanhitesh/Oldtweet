import { After, Then } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

Then('User enters Credit Score {string} and submits form and validates the response', async (creditScore: string) => {
  const fieldName = `${await browser.sharedStore.get('formFieldNames')}`;
  const isRequired = `${await browser.sharedStore.get('isRequired')}`;
  formPage.inputForAccount = fieldName;
  await formPage.waitForPresence(await formPage.inputforAccountDetails);
  await formPage.type(await formPage.inputforAccountDetails, creditScore);
  const regexSymbols = /[!@#$%^&*()_+\-=[\]{};':"\\|,<>/?]+/;
  if (regexSymbols.test(creditScore)) {
    const fieldValue = await formPage.getText(await formPage.inputforAccountDetails);
    expect(fieldValue.length).toEqual(0);
  } else if (creditScore.length > 0) {
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.refreshBrowser();
    await formPage.sleep(MilliSeconds.XS);
    const formResponseId = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${await browser.sharedStore.get(
          'formName',
        )}'`,
      )
    ).records[0].Id;
    const formFieldResponses = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}' ORDER BY PagesApi__Form_Response__c`,
      )
    ).records[0].PagesApi__Response__c;
    expect(formFieldResponses).toEqual(creditScore);
  } else if (creditScore.length === 0 && isRequired === 'true') {
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.XS);
    formPage.error = fieldName;
    expect(await formPage.getText(await formPage.errorMessage)).toEqual(fieldName.concat(` is required`));
  } else {
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.XS);
    formPage.error = fieldName;
    const formResponseId = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${await browser.sharedStore.get(
          'formName',
        )}'`,
      )
    ).records[0].Id;
    const formFieldResponses = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}' ORDER BY PagesApi__Form_Response__c`,
      )
    ).records[0].PagesApi__Response__c;
    expect(formFieldResponses).toEqual(null);
  }
});

After({ tags: '@TEST_PD-29724' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
