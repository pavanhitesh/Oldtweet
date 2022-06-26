import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

Then('User submits the form with Phone Number {string} and validates the response', async (phoneNumber: string) => {
  const fieldName = `${await browser.sharedStore.get('formFieldNames')}`;
  const isRequired = `${await browser.sharedStore.get('isRequired')}`;
  if (isRequired === 'true' && phoneNumber === 'NA') {
    await formPage.click(await formPage.submit);
    await formPage.sleep(MilliSeconds.XXXS);
    formPage.error = fieldName;
    expect(await formPage.getText(await formPage.errorMessage)).toEqual(fieldName.concat(' is required'));
  } else if (phoneNumber === 'YES') {
    const homePhonenum = faker.datatype.number({ min: 9000000000, max: 9999999999 }) as unknown as string;
    formPage.inputForAccount = fieldName;
    await formPage.type(await formPage.inputforAccountDetails, homePhonenum);
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.S);
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
    expect(formFieldResponse).toEqual(String(homePhonenum));
  } else if (isRequired === 'false' && phoneNumber === 'NA') {
    formPage.inputForAccount = fieldName;
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.S);
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
});

After({ tags: '@TEST_PD-29654' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Name = '${await browser.sharedStore.get(
    'formName',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
