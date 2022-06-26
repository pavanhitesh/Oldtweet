/* eslint-disable class-methods-use-this */
import * as faker from 'faker';
import { WebPage } from '../../../../globals/web/web.page';

class InvoiceMe extends WebPage {
  get linkInvoiceMe() {
    return $('li[title="Invoice Me"] a');
  }

  get customerReferenceNumber() {
    return $(`//div[@data-name="referenceNumber"]/input`);
  }

  get completeTransactionButton() {
    return $(`//button[@data-name="processBtn"]`);
  }

  async completeInvoiceMeTransaction() {
    await super.click(await this.linkInvoiceMe);
    await super.type(await this.customerReferenceNumber, faker.random.alphaNumeric(8));
    await super.click(await this.completeTransactionButton);
  }
}

export const invoiceMe = new InvoiceMe();
