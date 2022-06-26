/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class EventCheckoutPage extends WebPage {
  private paymentTypeLocator!: string;

  get savedPayment() {
    return $('//li[@title="Saved Payment Methods"]');
  }

  get savedPaymentList() {
    return $('//select[@name="Saved Payment Method"]');
  }

  get processPayment() {
    return $('//button[@aria-label="Process Payment"]');
  }

  get creditCompInstructions() {
    return $(
      `//div[@data-name="ccPaymentComp"]//div[@data-name="instructions"]/div | //div[@data-name="ccPaymentComp"]//div[@data-name="instructions"]//b `,
    );
  }

  set paymentType(linkName: string) {
    this.paymentTypeLocator = `//li[@title="${linkName}"]`;
  }

  get paymentTypeLink() {
    return $(this.paymentTypeLocator);
  }
}

export const eventCheckoutPage = new EventCheckoutPage();
