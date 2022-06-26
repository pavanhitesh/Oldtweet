import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

Then('User update the instructions on formGroup to the created form', async () => {
  localSharedData.instructions = faker.random.words(5);
  const updateInstructions = await conn.tooling.executeAnonymous(`
  PagesApi__Field_Group__c item = [Select id from PagesApi__Field_Group__c Where id = '${await browser.sharedStore.get(
    'groupIds',
  )}'];
  item.PagesApi__Instructions__c = '${localSharedData.instructions}';
  update item;`);
  expect(updateInstructions.success).toEqual(true);
});

Then('User validates the field group instructions and visibility of instructional text field on form', async () => {
  expect(await formPage.getText(await formPage.fieldGroupInstructions)).toEqual(localSharedData.instructions);

  formPage.formInformationalText = `${await browser.sharedStore.get('formFieldNames')}`;
  expect(await formPage.isDisplayed(await formPage.formInformationalTextDetails)).toEqual(true);
});

After({ tags: '@TEST_PD-29803' }, async () => {
  const deleteQuery = `DELETE [SELECT Id from PagesApi__Form__c where Id = '${await browser.sharedStore.get(
    'formId',
  )}'];`;
  const deleteForm = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteForm.success).toEqual(true);
});
