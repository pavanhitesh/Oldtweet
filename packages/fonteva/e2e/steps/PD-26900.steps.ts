import { When, Then } from '@cucumber/cucumber';
import { profilePage } from '../../pages/portal/profile.page';
import { conn } from '../../shared/helpers/force.helper';

Then(
  'User verifies check box of Mobile Do Not Call from Address Information should be read only for {string} contact',
  async (contact: string) => {
    const apexBody = `Contact doNotCall = [Select Id from Contact Where Name = '${contact}'];
    doNotCall.OrderApi__Mobile_Do_Not_Call__c = true;
    update doNotCall;`;
    await conn.tooling.executeAnonymous(apexBody);
    await browser.refresh();
    await profilePage.waitForPresence(await profilePage.mobileDoNotCallCheckbox_Profile);
    await profilePage.scrollToElement(await profilePage.mobileDoNotCallCheckbox_Profile);

    expect(await profilePage.isSelected(await profilePage.mobileDoNotCallCheckbox_Profile)).toEqual(true);
    expect(await profilePage.isEnabled(await profilePage.mobileDoNotCallCheckbox_Profile)).toEqual(false);
  },
);

When('User updates the Mobile Donot Call checkbox state to disable on profile page', async () => {
  await profilePage.click(await profilePage.changeAddressInfo);
  await profilePage.scrollToElement(await profilePage.save);
  await profilePage.click(await profilePage.mobileDoNotCallCheckbox_Change);
  expect(await profilePage.isDisplayed(await profilePage.save)).toEqual(true);
});

When('User clicks on Save button in address change', async () => {
  await profilePage.scrollToElement(await profilePage.save);
  await profilePage.click(await profilePage.save);
  await profilePage.waitForPresence(await profilePage.mobileDoNotCallCheckbox_Profile);
  expect(await profilePage.isDisplayed(await profilePage.mobileDoNotCallCheckbox_Profile)).toEqual(true);
});

Then('User verifies Mobile Do not Call check box is not selected in profile page', async () => {
  expect(await profilePage.isSelected(await profilePage.mobileDoNotCallCheckbox_Profile)).toEqual(false);
  expect(await profilePage.isEnabled(await profilePage.mobileDoNotCallCheckbox_Profile)).toEqual(false);
});
