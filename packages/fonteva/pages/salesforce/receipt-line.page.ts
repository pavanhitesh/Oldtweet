/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ReceiptLinePage extends WebPage {
  get header() {
    return $('//div[text() ="Receipt Line"]');
  }

  get itemQuantity() {
    return $('//button[@title="Edit Quantity"]');
  }

  get inputQuantity() {
    return $('//input[@name="OrderApi__Quantity__c"]');
  }

  get Save() {
    return $('//button[@name="SaveEdit"]');
  }

  get quantityValidationMessage() {
    return $('//div[contains(@id,"help-message")]');
  }
}

export const receiptLinePage = new ReceiptLinePage();
