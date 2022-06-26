import { Given, Then, When } from '@cucumber/cucumber';
import * as faker from 'faker';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { checkoutPage } from '../../pages/portal/checkout.page';

Given('User navigate to community Portal page', async () => {
  await portalLoginPage.open();
  await portalLoginPage.waitForClickable(await commonPortalPage.linkStore);
  expect(await portalLoginPage.isDisplayed(await commonPortalPage.linkStore)).toEqual(true);
});

When(
  'User select an item {string} from the store and add it to your cart and proceed to the checkout page',
  async (item: string) => {
    await commonPortalPage.clickStore();
    await commonPortalPage.selectItem(item);
    expect((await commonPortalPage.getStoreLabelText()).trim() === item);
    await commonPortalPage.click(await commonPortalPage.buttonAddtoCart);
    await commonPortalPage.waitForPresence(await commonPortalPage.cartButton);
    await commonPortalPage.click(await commonPortalPage.cartButton);
    await commonPortalPage.waitForPresence(await commonPortalPage.checkoutButton);
    await commonPortalPage.click(await commonPortalPage.checkoutButton);
    await commonPortalPage.waitForPresence(await commonPortalPage.checkoutPageLabel);
    expect((await commonPortalPage.getText(await commonPortalPage.checkoutPageLabel)).trim()).toEqual('Checkout');
  },
);

When('User select Continue as a Guest option', async () => {
  await commonPortalPage.waitForPresence(await commonPortalPage.textBoxSourceCode);
  if (await commonPortalPage.continueAsGuest.isDisplayed()) {
    await commonPortalPage.click(await commonPortalPage.continueAsGuest);
  }
  expect(await commonPortalPage.getText(await commonPortalPage.continueAsGuestLabel)).toEqual('Continue as Guest');
});

When('User fills in First, Last Name and Email', async () => {
  await browser.sharedStore.set('guestFirstName', faker.name.firstName());
  await browser.sharedStore.set('guestLastName', faker.name.lastName());
  await browser.sharedStore.set('guestEmail', faker.internet.email());
  await checkoutPage.fillGuestCheckoutDetails(
    (await browser.sharedStore.get('guestFirstName')) as string,
    (await browser.sharedStore.get('guestLastName')) as string,
    (await browser.sharedStore.get('guestEmail')) as string,
  );
  expect(await commonPortalPage.isEnabled(await commonPortalPage.guestRegistrationButton)).toBe(true);
});

Then('User clicks the multi selector drop down in checkout page', async () => {
  await commonPortalPage.waitForPresence(await commonPortalPage.multiSelectPickList);
  expect(await commonPortalPage.isDisplayed(await commonPortalPage.multiSelectPickList)).toEqual(true);
  await commonPortalPage.click(await commonPortalPage.multiSelectPickList);
});

Then('User should see the options in the multi select drop down', async () => {
  await commonPortalPage.sleep(MilliSeconds.XXS);
  await commonPortalPage.click(await commonPortalPage.picklistOptions);
  await commonPortalPage.sleep(MilliSeconds.XXS);
  expect(await commonPortalPage.getText(await commonPortalPage.selecetedOptionInMultiPicker)).not.toBe('');
});
