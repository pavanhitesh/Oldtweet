/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { commonPortalPage } from './common.page';

class CheckoutPage extends WebPage {
  get companyOrderInvoicePaymentContinue() {
    return $('//c-pfm-button[@data-name="continuePayment"]/button');
  }

  get totalCheckOutAmount() {
    return $('div[data-name="totalAmount"]');
  }

  get savePaymentMethodOption() {
    return $(`//div[@role='tabpanel' and contains(@class,'slds-show')]//label[@data-name='savePaymentMethod']`);
  }

  get checkoutLink() {
    return $('//a[@data-name="checkout"]');
  }

  get continueToEvent() {
    return $('//button[@data-name="continue-to-event"]');
  }

  get invalidOrderMessage() {
    return $(`//h1[@data-name="invalidMessage"]`);
  }

  async fillGuestCheckoutDetails(firstName: string, lastName: string, useremail: string) {
    await commonPortalPage.click(await commonPortalPage.firstName);
    await commonPortalPage.type(await commonPortalPage.firstName, firstName);
    await commonPortalPage.click(await commonPortalPage.lastName);
    await commonPortalPage.type(await commonPortalPage.lastName, lastName);
    await commonPortalPage.click(await commonPortalPage.email);
    await commonPortalPage.type(await commonPortalPage.email, useremail);
    await commonPortalPage.waitForEnable(await commonPortalPage.guestRegistrationButton);
  }
}

export const checkoutPage = new CheckoutPage();
