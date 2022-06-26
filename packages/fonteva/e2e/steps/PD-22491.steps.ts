import { Given, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { portalLoginPage } from '../../pages/portal/login.page';

Given(
  'User should update the default checkout value as {string} in {string} store',
  async (checkoutType: string, store: string) => {
    const apexBody = `OrderApi__Store__c checkoutType = [Select Id from OrderApi__Store__c Where Name = '${store}'];
    checkoutType.OrderApi__Default_Checkout__c = '${checkoutType}';
    update checkoutType;`;
    await conn.tooling.executeAnonymous(apexBody);
  },
);

Then('User should see {string} modal for guest login', async (heading: string) => {
  await portalLoginPage.waitForPresence(await portalLoginPage.alreadyMemberLoginBtn);
  expect(await portalLoginPage.getText(await portalLoginPage.guestLoginModalHeading)).toEqual(heading);
});
