/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ReceiptPage extends WebPage {
  get paymentConfirmationMessage() {
    return $('//div[text()="Payment Successful"]');
  }

  get eventConfirmationMessage() {
    return $('//div[contains(text(),"payment has been successful")]');
  }

  get eventReceiptId() {
    return $('//div[contains(text(),"Receipt")]');
  }

  get invoiceConfirmationMessage() {
    return $('//div[text()="Invoice Created"]');
  }

  get profileMenu() {
    return $('//div[@id="navbar"]//lightning-icon[contains(@class, "slds-icon-utility-user")]');
  }

  get profile() {
    return $('//a[@title="Profile"]');
  }

  get viewReceipt() {
    return $('//button[@data-name="view-receipt"]');
  }
}

export const receiptPage = new ReceiptPage();
