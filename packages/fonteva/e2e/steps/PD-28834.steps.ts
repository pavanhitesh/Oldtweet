import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$LTE__Menu_Item__c } from 'packages/fonteva/fonteva-schema';
import { communitySiteNewMenuPage } from '../../pages/salesforce/community-site-new-menu.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-28834' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User updates menuItem publicly available and Enable Access Permissions field to true', async () => {
  const menuItemResponse = await conn.tooling.executeAnonymous(`
  LTE__Menu_Item__c menuItem = [Select LTE__Enable_Access_Permissions__c FROM LTE__Menu_Item__c Where Name = '${
    (await browser.sharedStore.get('menuItemName')) as string
  }'];
  menuItem.LTE__Enable_Access_Permissions__c = true;
  menuItem.LTE__Publicly_Available__c = true;
  update menuItem;`);
  expect(menuItemResponse.success).toEqual(true);
  const accessPermissionResponse = await communitySiteNewMenuPage.addAccessPermissionToMenuItem(
    `${await browser.sharedStore.get('menuItemName')}`,
    'AutoBadge',
  );
  expect(accessPermissionResponse.success).toEqual(true);
});

After({ tags: '@TEST_PD-28834' }, async () => {
  const menuItemId = (
    await conn.query<Fields$LTE__Menu_Item__c>(
      `SELECT Id FROM LTE__Menu_Item__c WHERE Name = '${await browser.sharedStore.get('menuItemName')}'`,
    )
  ).records[0].Id;
  const deleteMenuItem = await conn.sobject('LTE__Menu_Item__c').destroy(menuItemId as string);
  expect(deleteMenuItem.success).toEqual(true);
});
