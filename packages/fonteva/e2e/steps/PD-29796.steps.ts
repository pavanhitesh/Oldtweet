import { After, DataTable, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';

const localSharedData: { [key: string]: string } = {};

Then('User update the submit style and submit value for the created form', async (formfieldData: DataTable) => {
  const fielUpdatingData = formfieldData.hashes();

  await fielUpdatingData.reduce(async (memo, styleData) => {
    localSharedData.submitValue = styleData.submitValue;
    const updateItemResponse = await conn.tooling.executeAnonymous(`
  PagesApi__Form__c item = [Select id from PagesApi__Form__c Where id = '${await browser.sharedStore.get('formId')}'];
  item.PagesApi__Submit_Style__c = '${styleData.submitStyle}';
  item.PagesApi__Submit_Value__c = '${styleData.submitValue}';
  update item;`);
    expect(updateItemResponse.success).toEqual(true);
  }, undefined);
});

Then(
  'User fills and submits the created form and validates whether user is navigated to different page as in submitValue',
  async () => {
    const accountName = faker.name.firstName();
    formPage.inputForAccount = `${await browser.sharedStore.get('formFieldNames')}`;
    await formPage.type(await formPage.inputforAccountDetails, accountName);
    expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(accountName);
    await formPage.waitForPresence(await formPage.submit);
    await formPage.click(await formPage.submit);
    await commonPortalPage.waitForBrowserUrlContains(localSharedData.submitValue);

    const currentUrl = await browser.getUrl();
    expect(currentUrl).toEqual(localSharedData.submitValue);
  },
);

After({ tags: '@TEST_PD-29797' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Id = '${await browser.sharedStore.get(
    'formId',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
});
