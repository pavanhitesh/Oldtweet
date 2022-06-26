import { Before, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { loginPage } from '../../pages/salesforce/login.page';
import { communitySitePage } from '../../pages/salesforce/community-site.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { communitySiteNewMenuPage } from '../../pages/salesforce/community-site-new-menu.page';
import * as data from '../data/PD-28787.json';

Before({ tags: '@TEST_PD-28787' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User creates new menu item with external url as {string} and verifies the validation message',
  async (url: string) => {
    await communitySitePage.click(await communitySitePage.relatedTab);
    await communitySitePage.click(await communitySitePage.newCommunityMenu);
    await communitySitePage.sleep(MilliSeconds.XXS);
    await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="accessibility title"]'));
    await communitySiteNewMenuPage.waitForPresence(await communitySiteNewMenuPage.communityNewMenuHeader);
    await communitySiteNewMenuPage.type(await communitySiteNewMenuPage.menuName, faker.name.firstName());
    await communitySiteNewMenuPage.type(await communitySiteNewMenuPage.menuUrl, url);
    await communitySiteNewMenuPage.click(await communitySiteNewMenuPage.save);
    await communitySitePage.waitForPresence(await communitySiteNewMenuPage.externalUrlValidation);
    expect(await communitySiteNewMenuPage.getText(await communitySiteNewMenuPage.externalUrlValidation)).toEqual(
      data.validationMessage,
    );
  },
);
