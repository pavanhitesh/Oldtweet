import { When, Then } from '@cucumber/cucumber';
import { profilePage } from '../../pages/portal/profile.page';
import { formPage } from '../../pages/portal/form.page';

When('User selects the profile menu {string} and navigate to multi entry checkbox form', async (menuItem: string) => {
  profilePage.selectProfilePage = menuItem;
  await profilePage.click(await profilePage.navigateToProfilePage);
  await formPage.waitForPresence(await formPage.addNewEntryButton);
  expect(await formPage.isDisplayed(await formPage.addNewEntryButton)).toEqual(true);
});

Then(
  'User edit the entry have isAuthorizedUser and verifies the correct value of checkbox based on the isAuthorizedUser value',
  async () => {
    (await Promise.all(await formPage.multiEntrySummariesList)).forEach(async (item) => {
      await formPage.click(await item.$(formPage.editMultiEntryRecord));
      await formPage.waitForPresence(await formPage.isAuthorizedUserCheckBox);
      if ((await formPage.getText(await item.$(formPage.isAuthorizedUserValue))) === 'true') {
        expect(await formPage.isSelected(await formPage.isAuthorizedUserCheckBoxValue)).toEqual(true);
      } else {
        expect(await formPage.isSelected(await formPage.isAuthorizedUserCheckBoxValue)).toEqual(false);
      }
    });
  },
);
