import { Before, Then } from '@cucumber/cucumber';
import * as clipboardy from 'clipboardy';
import { loginPage } from '../../pages/salesforce/login.page';
import { orderPage } from '../../pages/portal/orders.page';
import { viewOrderPage } from '../../pages/portal/view-orders.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { commonPortalPage } from '../../pages/portal/common.page';

Before({ tags: '@TEST_PD-27707' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should be able to copy and verify the order summary link', async () => {
  await orderPage.scrollToElement(await orderPage.viewOrder);
  await orderPage.click(await orderPage.viewOrder);
  await viewOrderPage.waitForPresence(await viewOrderPage.copyOrderLink);
  await viewOrderPage.click(await viewOrderPage.copyOrderLink);
  await commonPortalPage.sleep(MilliSeconds.XXS);
  await commonPortalPage.openNewWindow(await clipboardy.read());
  await commonPortalPage.sleep(MilliSeconds.XS);
  expect(await commonPortalPage.getWindowTitle()).toEqual('Order View');
});
