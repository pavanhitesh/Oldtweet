/* eslint-disable class-methods-use-this */
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { WebPage } from '../../../../globals/web/web.page';
import { communitySitePage } from './community-site.page';

class CommonPage extends WebPage {
  get edit() {
    return $(`//button[@name="Edit"]`);
  }

  get pageHeader() {
    return $(`//h1/div[contains(@class,'entityNameTitle')]`);
  }

  get save() {
    return $(`//button[@name="SaveEdit"]`);
  }

  get cancel() {
    return $('//button[@name="CancelEdit"]');
  }

  get saveError() {
    return $('//div[@class="genericNotification"]//following::ul');
  }

  get validationMessage() {
    return $('//div[contains(@id,"help-message")]');
  }

  get clone() {
    return $('//button[@name="Clone"]');
  }

  get relatedTab() {
    return $('//a[@id="relatedListsTab__item"]');
  }

  async openCommunitySitePage(siteId: string) {
    await super.open(`/lightning/r/LTE__Site__c/${siteId}/view`);
    await super.sleep(MilliSeconds.S);
    await super.waitForPresence(await communitySitePage.communityHeader);
  }
}
export const commonPage = new CommonPage();
