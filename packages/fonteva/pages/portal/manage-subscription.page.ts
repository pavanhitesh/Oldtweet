/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ManageSubscriptionPage extends WebPage {
  get updatePaymentMethod() {
    return $('//button[@data-name="update_payment_method"]');
  }

  get savedPaymentMethod() {
    return $('//select[@name="Saved Payment Method"]');
  }

  get done() {
    return $('//button[@data-name="submitBtn"]');
  }

  get renew() {
    return $(`//a[contains(@title,"Renew")]`);
  }

  get paymentMethodValue() {
    return $(`//div[@class='LTESubscriptionsManage']//div[text()='Payment Method:']/following-sibling::div`);
  }
}

export const manageSubscriptionPage = new ManageSubscriptionPage();
