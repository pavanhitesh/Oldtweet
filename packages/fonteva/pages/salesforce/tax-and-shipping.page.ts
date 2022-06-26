/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class TaxAndShippingPage extends WebPage {
  get continue() {
    return $('//c-pfm-button[@data-name="continueButton"]/button');
  }

  get title() {
    return $('//c-pfm-text[@data-name="shippingTaxTitle"]');
  }

  get shippingAndTaxPageHeader() {
    return $(`//h3[contains(.,'Shipping and Tax')]`);
  }

  get iframe() {
    return $('iframe[title="accessibility title"]');
  }

  get shippingMethod() {
    return $(`//td[@data-label="Shipping Method"]//select`);
  }

  get shippingCost() {
    return $(`//td[@data-label="Amount"]//input[@name="value"]`);
  }
}
export const taxAndShippingPage = new TaxAndShippingPage();
