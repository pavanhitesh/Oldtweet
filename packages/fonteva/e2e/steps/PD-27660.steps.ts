/* eslint-disable no-restricted-syntax */
import { DataTable, Then } from '@cucumber/cucumber';
import { profilePage } from '../../pages/portal/profile.page';

Then('User will verify the fieldset fields in portal that has following details', async (table: DataTable) => {
  const dataTable = table.hashes();
  for (const row of dataTable) {
    await profilePage.scrollToElement(await $(`//div[@data-field="${row.Field}"]`));
    expect(await profilePage.getText(await $(`//div[@data-field="${row.Field}"]/div[1]`))).toEqual(row.Label);
    expect(await profilePage.getText(await $(`//div[@data-field="${row.Field}"]/div[2]`))).not.toBe('');
  }
});
