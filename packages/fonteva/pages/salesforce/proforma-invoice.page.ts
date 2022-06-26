/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { salesOrderPage } from './salesorder.page';

class ProformaInvoicePage extends WebPage {
  get emailSentSuccessMessage() {
    return $(`//div[text()='Your Email Has Been Sent.']`);
  }

  get sendEmail() {
    return $(`//button[@data-name='invSendEmailButton']`);
  }

  get paymentLinkEmailBody() {
    return $(`//div[@data-name="message"]//a[text()='Click here to make a payment']`);
  }

  get proformaInvoicePageHeader() {
    return $(`//div[contains(@class,'OrderApiSalesOrderProformaInvoice')]//span[text()='Create Proforma Invoice']`);
  }

  get exitButton() {
    return $('button[data-name="exitBtn"]');
  }

  get closeButton() {
    return $('//button[@data-label="Close"]');
  }

  async exitToSalesOrder() {
    await super.click(await this.exitButton);
    await super.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  }

  async getPaymentLinkFromEmail() {
    return super.getAttributeValue(await this.paymentLinkEmailBody, 'href');
  }

  get sendTo() {
    return $('//div[@data-label="Send To"]/input');
  }
}

export const proformaInvoicePage = new ProformaInvoicePage();
