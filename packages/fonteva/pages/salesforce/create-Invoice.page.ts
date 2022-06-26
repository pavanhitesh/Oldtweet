/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class CreateInvoicePage extends WebPage {
  private itemPrice!: string;

  get readyForPaymentButton() {
    return $(`//button[text()='Ready For Payment' and @data-name='closePostButton']`);
  }

  get orderTotal() {
    return $(
      `//div[contains(@class,'OrderApiSalesOrderSummary')]//span[text()='Order Total']//span[contains(@class,'currency')]`,
    );
  }

  set itemPriceValueName(itemName: string) {
    this.itemPrice = `//tr[contains(@class,'OrderApiSalesOrderSummaryLine') and not (contains(@class,'hidden'))]//span[text()='${itemName}']/../..//span[contains(@class,'currencyInputSpan')]`;
  }

  get itemPriceValue() {
    return $(this.itemPrice);
  }

  get returnToPreviousPage() {
    return $(`//button[@data-label="Return to Previous Page"]`);
  }

  get paymentTermTextBox() {
    return $(`//div[@data-name="paymentTerms"]//input`);
  }

  get clearSearch() {
    return $(`//div[@data-label="Payment Terms"]//img[@alt="Clear Search"]`);
  }
}

export const createInvoicePage = new CreateInvoicePage();
