import { Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { communitySitePage } from '../../pages/salesforce/community-site.page';
import { communitySiteNewMenuPage } from '../../pages/salesforce/community-site-new-menu.page';

import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

Before({ tags: '@TEST_PD-27640' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User should be able to add new custom community menu item with {string} {string} {string}',
  async (name: string, type: string, url: string) => {
    await communitySitePage.click(await communitySitePage.relatedTab);
    await communitySitePage.click(await communitySitePage.newCommunityMenu);
    await communitySitePage.sleep(MilliSeconds.M);
    const frame = await (await $('html')).shadow$('iframe[title="accessibility title"]');
    await browser.switchToFrame(frame);
    await communitySiteNewMenuPage.waitForPresence(await communitySiteNewMenuPage.communityNewMenuHeader);
    await communitySiteNewMenuPage.type(await communitySiteNewMenuPage.menuName, name);
    await communitySiteNewMenuPage.selectByVisibleText(await communitySiteNewMenuPage.menuType, type);
    await communitySiteNewMenuPage.type(await communitySiteNewMenuPage.menuUrl, url);
    await communitySiteNewMenuPage.click(await communitySiteNewMenuPage.save);
    await communitySiteNewMenuPage.sleep(MilliSeconds.M);
    const { records } = await conn.query(
      `Select LTE__Type__c, LTE__URL__c from LTE__Menu_Item__c where Name ='${name}'`,
    );
    expect(records[0].LTE__Type__c).toEqual(type);
    expect(records[0].LTE__URL__c).toEqual(url);
  },
);
