import { After, Then } from '@cucumber/cucumber';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

Then('User set the Checkbox as {string} and Submit the form and verify response', async (setCheckbox: string) => {
  const isRequired = `${await browser.sharedStore.get('isRequired')}`;
  const fieldName = `${await browser.sharedStore.get('formFieldNames')}`;
  if (isRequired === 'true' && setCheckbox === 'OFF') {
    await formPage.click(await formPage.submit);
    await formPage.waitForPresence(await formPage.name);
    formPage.errorLabelElement = fieldName;
    expect(await formPage.getText(await formPage.errorLabelElementDetails)).toEqual(fieldName.concat(' is required'));
    const formResponseRecords = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__c = '${await browser.sharedStore.get(
          'formId',
        )}'`,
      )
    ).records;
    expect(formResponseRecords.length).toEqual(0);
  } else {
    if (setCheckbox === 'ON') {
      formPage.formlabelElement = fieldName;
      await formPage.mouseHoverOver(await formPage.formlabelElementDetails);
      await formPage.scrollToElement(await formPage.formlabelElementDetails);
      await formPage.sleep(MilliSeconds.XXS);
      await formPage.click(await formPage.formlabelElementDetails);
    }
    await formPage.click(await formPage.submit);
    await formPage.waitForPresence(await formPage.name);
    await formPage.sleep(MilliSeconds.XXS);
    await formPage.refreshBrowser();
    await formPage.waitForPresence(await formPage.name);
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
    if (setCheckbox === 'ON') {
      expect(formFieldResponse).toEqual('true');
    } else {
      expect(formFieldResponse).toEqual('false');
    }
  }
});

After({ tags: '@TEST_PD-29719' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Id = '${await browser.sharedStore.get(
    'formId',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);
});
