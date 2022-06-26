/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { rapidOrderEntryPage } from './rapid-order-entry.page';

class SalesOrderPage extends WebPage {
  private salesOrderId!: string;

  get salesOrderPageHeader() {
    return $(`//h1/div[contains(@class,'entityNameTitle') and text()='Sales Order']`);
  }

  get salesOrderNumber() {
    return $(
      `//div[contains(@class,'entityNameTitle') and text()='Sales Order']/parent::h1/slot[@name='primaryField']//lightning-formatted-text`,
    );
  }

  get readyForPayment() {
    return $('//button[text()="Ready For Payment"]');
  }

  get applyPayment() {
    return $('//button[text()="Apply Payment"]');
  }

  get moreActions() {
    return $('//span[contains(text(),"Show more actions")]/ancestor::button[1]');
  }

  get createCreditMemo() {
    return $('//a[@name="LTE__Create_Credit_Memo"]/span[text()="Create Credit Memo"]');
  }

  get createCreditNotesButton() {
    return $('a[title="Create Credit Note"]');
  }

  get viewDocument() {
    return $(`//button[text()='View Document']`);
  }

  async getSalesOrderId() {
    const salesOrderId = await super.getText(await this.salesOrderNumber);
    return salesOrderId;
  }

  get rapidOrderEntry() {
    return $(`//button[text()='Rapid Order Entry']`);
  }

  get rapidOrderEntryMenu() {
    return $(`//span[text()='Rapid Order Entry']`);
  }

  get details() {
    return $(`//a[text()='Related']`);
  }

  set salesOrderLineId(Id: string) {
    this.salesOrderId = `//a[@data-recordid="${Id}"]`;
  }

  get salesOrderLineIdDisplayed() {
    return $(this.salesOrderId);
  }

  get salesOrderLineTitle() {
    return $(`//span[@title="Sales Order Lines"]`);
  }

  async openRapidOrderEntryPage() {
    if ((await super.isDisplayed(await this.rapidOrderEntry)) === false) {
      await super.click(await this.moreActions);
      await super.click(await this.rapidOrderEntryMenu);
    } else {
      await super.click(await this.rapidOrderEntry);
    }
    await super.waitForPresence(await rapidOrderEntryPage.itemQuickAddTextBox);
  }
}

export const salesOrderPage = new SalesOrderPage();
