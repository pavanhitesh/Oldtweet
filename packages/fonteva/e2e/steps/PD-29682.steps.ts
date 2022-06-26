import { After, Then } from '@cucumber/cucumber';
import faker from 'faker';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

Then('User submits the form with Email value as {string} and validates the Response', async (validEmail: string) => {
  formPage.inputForAccount = `${await browser.sharedStore.get('formFieldTypes')}`;
  const isRequired = `${await browser.sharedStore.get('isRequired')}`;

  if (validEmail === 'true') {
    const emailValue = faker.internet.email();
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    await formPage.type(await formPage.inputforAccountDetails, emailValue);
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

    expect(formFieldResponse).toEqual(emailValue);
  } else if (validEmail === 'NA') {
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.XS);

    if (isRequired === 'true') {
      formPage.error = `${await browser.sharedStore.get('formFieldNames')}`;
      expect(await formPage.getText(await formPage.errorMessage)).toEqual(
        `${await browser.sharedStore.get('formFieldNames')}`.concat(` is required`),
      );
    } else {
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
  } else if (validEmail === 'false') {
    const emailValue = faker.name.firstName();
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    await formPage.type(await formPage.inputforAccountDetails, emailValue);
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.XS);
    formPage.error = `${await browser.sharedStore.get('formFieldNames')}`;
    expect(await formPage.getText(await formPage.errorMessage)).toContain(`Invalid Email Format`);
  }
});

After({ tags: '@TEST_PD-29683' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
