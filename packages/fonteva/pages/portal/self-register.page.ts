/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class SelfRegisterPage extends WebPage {
  get logo() {
    return $('//img[@alt="LTCommunity"]');
  }

  get createAccount() {
    return $('//button[@data-label="Create Account"]');
  }

  get firstName() {
    return $('//div[@data-name="FirstName"]//input');
  }

  get lastName() {
    return $('//div[@data-name="LastName"]//input');
  }

  get email() {
    return $('//div[@data-name="Email"]//input');
  }

  get userName() {
    return $('//label[text()="Username"]//following::input');
  }

  get password() {
    return $('//label[text()="Password"]//following::input');
  }

  get guestContinueButton() {
    return $(
      `//div[@data-name="registerAsGuest"]//button[@data-name="guestRegistrationButton" and @data-label="Continue"]`,
    );
  }
}
export const portalSelfRegisterPage = new SelfRegisterPage();
