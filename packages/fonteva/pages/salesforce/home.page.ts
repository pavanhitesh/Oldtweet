/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

/**
 * sub page containing specific selectors and methods for a specific page
 */
class HomePage extends WebPage {
  get selectContactsList() {
    return $$('.listContent ul li div span div');
  }

  get searchBar() {
    return $('input[title="Search..."]');
  }

  get loginToExperienceUser() {
    return $('button[name="LoginToNetworkAsUser"]');
  }

  get setup() {
    return $('#setupLink');
  }

  // TODO: need to delete .. don't use

  async selectContact(contactName: string) {
    await super.click(await this.searchBar);
    await super.type(await this.searchBar, contactName);
    (await this.selectContactsList).forEach(async (contact) => {
      if ((await contact.getText()) === contactName) {
        await contact.click();
      }
    });
  }

  open(path: string) {
    return super.open(path);
  }

  // getUrl() {
  //   return super.getUrl();
  // }
}

export const homePage = new HomePage();
