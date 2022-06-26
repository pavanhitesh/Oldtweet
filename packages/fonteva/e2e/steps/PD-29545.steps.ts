import { After, Then } from '@cucumber/cucumber';
import { Fields$PagesApi__Field_Response__c, Fields$PagesApi__Form_Response__c } from 'packages/fonteva/fonteva-schema';
import * as faker from 'faker';
import { conn } from '../../shared/helpers/force.helper';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string } = {};

Then('User fills the data for firstName and lastName and submit the form', async () => {
  localSharedData.firstName = faker.name.firstName();
  localSharedData.lastName = faker.name.lastName();
  await formPage.waitForPresence(await formPage.newEntryButton);
  await formPage.click(await formPage.newEntryButton);
  await formPage.waitForPresence(await formPage.multiEntryModal);
  expect(await formPage.isDisplayed(await formPage.multiEntryModal)).toEqual(true);
  formPage.inputForContact = 'FirstName';
  await formPage.type(await formPage.inputforContactDetails, localSharedData.firstName);
  formPage.inputForContact = 'LastName';
  await formPage.type(await formPage.inputforContactDetails, localSharedData.lastName);
  await formPage.click(await formPage.addEntryButton);
  formPage.contactSummary = 'FirstName';
  await formPage.waitForPresence(await formPage.contactSummaryDetails);
  const actualFirstNameText = await formPage.getText(await formPage.contactSummaryDetails);
  expect(actualFirstNameText).toBe(localSharedData.firstName);
  formPage.contactSummary = 'LastName';
  const actualLastNameText = await formPage.getText(await formPage.contactSummaryDetails);
  expect(actualLastNameText).toBe(localSharedData.lastName);
  await formPage.click(await formPage.submit);
  await formPage.waitForPresence(await formPage.name);
  expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
});

Then('User verifies the form responses {string}', async (formName: string) => {
  await formPage.sleep(MilliSeconds.XXS);
  localSharedData.formName = formName;
  localSharedData.formResponseId = (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id FROM PagesApi__Form_Response__c WHERE PagesApi__Form__r.Name = '${localSharedData.formName}'`,
    )
  ).records[0].Id;
  const formFieldResponses = (
    await conn.query<Fields$PagesApi__Field_Response__c>(
      `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${localSharedData.formResponseId}' ORDER BY PagesApi__Form_Response__c`,
    )
  ).records;
  expect(formFieldResponses[0].PagesApi__Response__c).toEqual(localSharedData.firstName);
  expect(formFieldResponses[1].PagesApi__Response__c).toEqual(localSharedData.lastName);
});

After({ tags: '@TEST_PD-29546' }, async () => {
  const formResponseId = await (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records[0].Id;
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
});
