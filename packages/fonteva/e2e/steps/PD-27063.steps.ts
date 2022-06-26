import { Before, Then } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';

Before({ tags: '@TEST_PD-28186' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User should be able to assign the contact {string} for the subscription item {string}',
  async (contact: string, item: string) => {
    await rapidOrderEntryPage.expandItemtoViewDetails(item);
    await rapidOrderEntryPage.sleep(MilliSeconds.XXS);
    await rapidOrderEntryPage.scrollToElement(await rapidOrderEntryPage.assignContactInputBox);
    await rapidOrderEntryPage.slowTypeFlex(await rapidOrderEntryPage.assignContactInputBox, contact);
    await browser.keys(['Enter']);
    await rapidOrderEntryPage.waitForEnable(await rapidOrderEntryPage.assign);
    await rapidOrderEntryPage.click(await rapidOrderEntryPage.assign);
    await rapidOrderEntryPage.waitForAjaxCall();
    expect(await rapidOrderEntryPage.verifyAssignedContact(contact)).toBe(true);
  },
);
