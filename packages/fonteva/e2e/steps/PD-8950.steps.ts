import { Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { profilePage } from '../../pages/portal/profile.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$LTE__Menu_Item__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

Then('User updates menuItem name field', async () => {
  localSharedData.menuUpdatedName = faker.name.firstName();
  const menuItemResponse = await conn.tooling.executeAnonymous(`
  LTE__Menu_Item__c menuItem = [Select Name FROM LTE__Menu_Item__c Where Name = '${
    (await browser.sharedStore.get('menuItemName')) as string
  }'];
  menuItem.Name = '${localSharedData.menuUpdatedName as string}';
  update menuItem;`);
  expect(menuItemResponse.success).toEqual(true);
});

Then('User verifies updated menuItem name is displayed', async () => {
  await browser.refresh();
  profilePage.menuItem = localSharedData.menuUpdatedName as string;
  await profilePage.waitForPresence(await profilePage.menuItemDisplayed);
  expect(await profilePage.isDisplayed(await profilePage.menuItemDisplayed)).toEqual(true);
});

Then('User verifies created menuItem is displayed', async () => {
  profilePage.menuItem = (await browser.sharedStore.get('menuItemName')) as string;
  await profilePage.waitForPresence(await profilePage.menuItemDisplayed);
  expect(await profilePage.isDisplayed(await profilePage.menuItemDisplayed)).toEqual(true);
});

Then('User deletes the menuItem and verifies the menuItem is deleted', async () => {
  const menuItemId = (
    await conn.query<Fields$LTE__Menu_Item__c>(
      `SELECT Id FROM LTE__Menu_Item__c WHERE Name = '${localSharedData.menuUpdatedName}'`,
    )
  ).records[0].Id;
  const deleteMenuItem = await conn.sobject('LTE__Menu_Item__c').destroy(menuItemId as string);
  expect(deleteMenuItem.success).toEqual(true);
});
