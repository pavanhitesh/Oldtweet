import { Then, When } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { commonPortalPage } from '../../pages/portal/common.page';

const localSharedData: { [key: string]: string | string[] } = {};

When('User clicks on the link from item description', async () => {
  localSharedData.oldHandle = await browser.getWindowHandle();
  await commonPortalPage.click(await commonPortalPage.linkDescription);
  await commonPortalPage.sleep(MilliSeconds.XXS);
  localSharedData.handles = await browser.getWindowHandles();
  expect(localSharedData.handles.length).toEqual(2);
});

Then('User verifies the item details page of item {string} is opened in new window', async (item: string) => {
  (localSharedData.handles as string[]).forEach(async (handle) => {
    if (handle !== localSharedData.oldHandle) await commonPortalPage.switchToWindowHandle(handle);
  });

  expect((await commonPortalPage.getStoreLabelText()).trim()).toEqual(item);
});
