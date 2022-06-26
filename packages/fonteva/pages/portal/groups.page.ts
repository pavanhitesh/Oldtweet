/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class GroupsPage extends WebPage {
  get groups() {
    return $('//div[text()="Groups"]');
  }

  get expandPostLink() {
    return $('//a[@title="Show more text"]');
  }

  get expandPostCommentsLink() {
    return $('//li[@class="slds-item qe-commentCount"]//following::a[@title="Show more text"]');
  }
}

export const groupsPage = new GroupsPage();
