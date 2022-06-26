/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class CommunitySitePage extends WebPage {
  get communityHeader() {
    return $('//slot[@slot="primaryField"]');
  }

  get relatedTab() {
    return $('//a[@id="relatedListsTab__item"]');
  }

  get newCommunityMenu() {
    return $('//span[@title="Community Menu Items"]//following::button[text()="New"]');
  }

  get new() {
    return $('//a[@title="New"]');
  }

  get siteCreationValidation() {
    return $('//div[@class="iziToast-body"]/p');
  }
}
export const communitySitePage = new CommunitySitePage();
