/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { Fields$LTE__Site__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

/**
 * sub page containing specific selectors and methods for a specific page
 */
class LoginPage extends WebPage {
  #siteLoginUrl = '/login';

  get guestLoginModalHeading() {
    return $('//div[@data-name="FirstName"]//preceding-sibling::div');
  }

  get alreadyMemberLoginBtn() {
    return $(`//div[text()='Already a member? Login here.']/following::button[@data-label="Login"]`);
  }

  get username() {
    return $('input[placeholder="Username"]');
  }

  get password() {
    return $('input[placeholder="Password"]');
  }

  get login() {
    return $('//button[contains(@class,"loginButton")]');
  }

  get loginLink() {
    return $('a[title="Log In"]');
  }

  get notMember() {
    return $('//a[text()="Not a member?"]');
  }

  /**
   * a method to encapsule automation code to interact with the page
   * e.g. to login using username and password
   */
  async portalLogin(username: string, password: string) {
    await super.type(await this.username, username);
    await super.type(await this.password, password);
    await super.sleep(2000);
    await super.click(await this.login);
  }

  async navigateToLoginPage() {
    await super.click(await this.loginLink);
  }

  async open() {
    const result = await conn.query<Fields$LTE__Site__c>(
      `SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`,
    );
    await browser.sharedStore.set('portalUrl', result.records[0].LTE__Site_URL__c as string);
    await super.open(`${await browser.sharedStore.get('portalUrl')}`);
  }

  async openLT(path: string) {
    await browser.url(path + this.#siteLoginUrl);
  }
}

export const portalLoginPage = new LoginPage();
