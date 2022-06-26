/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ShoppingCartPage extends WebPage {
  get cartCheckout() {
    return $('[data-name="checkoutButton"]');
  }

  get header() {
    return $('//h4[text() = "Shopping Cart"]');
  }

  get itemPrice() {
    return $('//div[contains(@class,"LTEStoreDetail")]//span[contains(@class, "FrameworkCurrencyField")]');
  }

  get itemEdit() {
    return $('//a[text()="Edit"]');
  }

  get totalCheckOutAmount() {
    return $(`//div[@data-name="totalAmount"]//span[contains(@class,'Currency')]`);
  }
}

export const shoppingCartPage = new ShoppingCartPage();
