/* eslint-disable no-console */
import { Before, Then, When } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { commonPortalPage } from '../../pages/portal/common.page';

Before({ tags: '@TEST_PD-27798' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

When('User selects Add to Cart from Additional items page without selecting additional item', async () => {
  await commonPortalPage.sleep(MilliSeconds.XXS);
  await commonPortalPage.waitForPresence(await commonPortalPage.additionalItems);
  expect(await commonPortalPage.isDisplayed(await commonPortalPage.additionalItems)).toEqual(true); // validate additional items page
  expect(await commonPortalPage.isEnabled(await commonPortalPage.addtoCartFromAdditionalItems)).toEqual(true); // validate Add to cart is enabled without selecting additional item

  await commonPortalPage.click(await commonPortalPage.addtoCartFromAdditionalItems); // clicks on add to cart from additional items
  await commonPortalPage.waitForPresence(await commonPortalPage.buttonAddtoCart); // waiting for add to order button is present
  expect(await commonPortalPage.isDisplayed(await commonPortalPage.buttonAddtoCart)).toEqual(true);
});

Then('User verifies the cart is having only {string} item', async (item: string) => {
  const itemNames = await commonPortalPage.getItemsInShoppingCart();
  expect(itemNames.length).toEqual(1);
  expect(itemNames[0]).toEqual(item);
});
