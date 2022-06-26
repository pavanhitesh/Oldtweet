import { After, Then } from '@cucumber/cucumber';
import { profilePage } from '../../pages/portal/profile.page';
import { conn } from '../../shared/helpers/force.helper';
import { communitySiteNewMenuPage } from '../../pages/salesforce/community-site-new-menu.page';
import { Fields$LTE__Menu_Item__c } from '../../fonteva-schema';

Then('User creates menuItem for {string} Community Site', async (communitySite: string) => {
  const addMenuItemResponse = await communitySiteNewMenuPage.addMenuItem(communitySite);
  expect(addMenuItemResponse.success).toEqual(true);
});

Then('User updates menuItem publicly available field to false', async () => {
  const menuItemResponse = await conn.tooling.executeAnonymous(`
  LTE__Menu_Item__c menuItem = [Select LTE__Publicly_Available__c FROM LTE__Menu_Item__c Where Name = '${
    (await browser.sharedStore.get('menuItemName')) as string
  }'];
  menuItem.LTE__Publicly_Available__c = false;
  update menuItem;`);
  expect(menuItemResponse.success).toEqual(true);
});

Then('User verifies menuItem is not displayed for guest user', async () => {
  expect(
    await profilePage.isDisplayed(
      await $(`//a[@title='${(await browser.sharedStore.get('menuItemName')) as string}']`),
    ),
  ).toEqual(false);
});

After({ tags: '@TEST_PD-28812' }, async () => {
  const menuItemId = (
    await conn.query<Fields$LTE__Menu_Item__c>(
      `SELECT Id FROM LTE__Menu_Item__c WHERE Name = '${await browser.sharedStore.get('menuItemName')}'`,
    )
  ).records[0].Id;
  const deleteMenuItem = await conn.sobject('LTE__Menu_Item__c').destroy(menuItemId);
  expect(deleteMenuItem.success).toEqual(true);
});
