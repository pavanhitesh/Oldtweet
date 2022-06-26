import { Before, Given, When } from '@cucumber/cucumber';
import { commonPortalPage } from '../../pages/portal/common.page';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-27045' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

When('User navigated to store of the community portal', async () => {
  await commonPortalPage.clickStore();
  expect((await commonPortalPage.getStoreLabelText()).trim()).toEqual('Store');
});

When('User selected an item {string} from the catalog', async (item: string) => {
  await commonPortalPage.selectItem(item);
  expect((await commonPortalPage.getStoreLabelText()).trim()).toEqual(item);
});

When('User open the current url in new window', async () => {
  await commonPortalPage.waitForPresence(await commonPortalPage.linkStore);
  await commonPortalPage.openNewWindow(await commonPortalPage.getUrl());
  await commonPortalPage.waitForPresence(await commonPortalPage.linkStore);
  expect(await commonPortalPage.getUrl()).toContain('detail');
});

Given('Item details page of item {string} is displayed', async (item: string) => {
  expect((await commonPortalPage.getStoreLabelText()).trim()).toEqual(item);
});

When('User clicks on category {string}', async (category: string) => {
  await commonPortalPage.waitForPresence(await commonPortalPage.linkStore);
  await commonPortalPage.click(await $(`a[title="${category}"]`));
  expect((await commonPortalPage.getStoreLabelText()).trim()).toEqual(category);
});

Given('User verifies the URL should not be null', async () => {
  await commonPortalPage.waitForPresence(await commonPortalPage.linkStore);
  expect(await commonPortalPage.getUrl()).not.toBeNull();
});
