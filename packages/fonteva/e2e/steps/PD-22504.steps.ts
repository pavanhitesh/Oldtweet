import { Before, When } from '@cucumber/cucumber';
import { storePage } from '../../pages/portal/store.page';
import { commonPortalPage } from '../../pages/portal/common.page';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-27608' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});
When('User verifies Quantity is 1', async () => {
  const quantityLabel = await commonPortalPage.getText(await commonPortalPage.itemQuantityInCheckout);
  const quantity: string[] = quantityLabel.split(':');
  expect(quantity[1].trim()).toEqual('1');
});
When('User will select the {string} menu in LT Portal', async (menu: string) => {
  await commonPortalPage.click(await commonPortalPage.linkStore);
  const storeLabel: string = await commonPortalPage.getStoreLabelText();
  expect(storeLabel.trim()).toEqual(menu);
});
When('User select an item {string} from the store', async (item: string) => {
  await commonPortalPage.selectItem(item);
  const storeLabel: string = await commonPortalPage.getStoreLabelText();
  expect(storeLabel.trim()).toEqual(item);
});
When('User should not be able to edit the quantity', async () => {
  expect(await storePage.isDisplayed(await storePage.quantity)).toEqual(false);
});
When('User clicks on add to order button from store and add to cart button in item details page', async () => {
  await commonPortalPage.click(await commonPortalPage.buttonAddtoCart);

  await commonPortalPage.click(await commonPortalPage.buttonAddtoCartFromItemDetails);

  await commonPortalPage.waitForPresence(await commonPortalPage.cartButton);
  await commonPortalPage.click(await commonPortalPage.cartButton);

  await commonPortalPage.waitForPresence(await commonPortalPage.checkoutButton);
  await commonPortalPage.click(await commonPortalPage.checkoutButton);
  await commonPortalPage.waitForPresence(await commonPortalPage.checkoutPageLabel);

  await commonPortalPage.waitForPresence(await commonPortalPage.checkoutPageLabel);
  expect((await commonPortalPage.getText(await commonPortalPage.checkoutPageLabel)).trim()).toEqual('Checkout');
});
