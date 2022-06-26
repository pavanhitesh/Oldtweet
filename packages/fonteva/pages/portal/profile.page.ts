/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ProfilePage extends WebPage {
  private menuItemName!: string;

  private page!: string;

  get pageheader() {
    return $('[data-id="subHeaderTitle"]');
  }

  get mobileDoNotCallCheckbox_Profile() {
    return $('//div[@data-field="OrderApi__Mobile_Do_Not_Call__c"]//input');
  }

  get changeAddressInfo() {
    return $('//button[@aria-label="Change Address Information"]//span');
  }

  get mobileDoNotCallCheckbox_Change() {
    return $('//div[contains(@id,"Mobile_Do_Not_Call")]');
  }

  get save() {
    return $('//button[@data-name="saveBtn"]');
  }

  get hyperlink() {
    return $('[data-field="Hyperlink__c"] > div:nth-child(1)');
  }

  get hyperlinkUrl() {
    return $('//div[@data-field="Hyperlink__c"]//following::a');
  }

  set menuItem(itemName: string) {
    this.menuItemName = `//a[@title="${itemName}"]`;
  }

  get menuItemDisplayed() {
    return $(this.menuItemName);
  }

  set selectProfilePage(pageName: string) {
    this.page = `//a[@title="${pageName}"]`;
  }

  get navigateToProfilePage() {
    return $(this.page);
  }
}

export const profilePage = new ProfilePage();
