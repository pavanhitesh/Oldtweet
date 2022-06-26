/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ReceiptPage extends WebPage {
  get createRefund() {
    return $('//runtime_platform_actions-action-renderer[@apiname="LTE__Create_Refund"]');
  }

  get receiptNumber() {
    return $('//slot[@name="primaryField"]//lightning-formatted-text');
  }

  get buttonProcessRefund() {
    return $('//button[text()="Process Refund"]');
  }

  get refundConfirmation() {
    return $('//p[text()="Refund has been processed"]');
  }
}
export const receiptPage = new ReceiptPage();
