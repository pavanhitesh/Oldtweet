import { Then } from '@cucumber/cucumber';
import { groupsPage } from '../../pages/portal/groups.page';

Then('User opens {string} group and verifies Expand Post links on Chatter Posts', async (group: string) => {
  await groupsPage.click(await groupsPage.groups);
  await groupsPage.click(await $(`//a[text() = '${group}']`));
  await groupsPage.waitForPresence(await groupsPage.expandPostLink);
  expect(await groupsPage.isDisplayed(await groupsPage.expandPostLink)).toEqual(true);
  expect(await groupsPage.isDisplayed(await groupsPage.expandPostCommentsLink)).toEqual(true);
  await groupsPage.click(await groupsPage.expandPostLink);
  await groupsPage.click(await groupsPage.expandPostCommentsLink);
});
