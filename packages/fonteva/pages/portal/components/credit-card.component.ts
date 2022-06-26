/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../../globals/web/web.page';

class CreditCardComponent extends WebPage {
  get linkCreditCard() {
    return $('li[title="Credit Card"] a');
  }

  get paymentContainer() {
    return $('div[data-name="ccPaymentComp"]');
  }

  get buttonProcessPayment() {
    return $('//button[@data-name="processBtn" or @data-name="placeOrder"]');
  }

  get buttonConfirmOrder() {
    return $('button[data-name="Confirm_Order"]');
  }

  get textBoxCardHolderName() {
    return $('div[data-name="full_name"] input');
  }

  get textBoxCardNumber() {
    return $('#card_number');
  }

  get selectExpMonth() {
    return $('select[name="Exp Month"]');
  }

  get selectExpYear() {
    return $('select[name="Exp Year"]');
  }

  async addNewCreditCardDetails(cardNumber: string, cvvNumber: string, expMonth: string, expYear: string) {
    await super.click(await this.linkCreditCard);
    await super.waitForPresence(await this.paymentContainer);
    const frame = await (await $('html')).shadow$('iframe[title="Credit Card Input Frame"]');
    await browser.switchToFrame(frame);
    const cardFrame = await (await $('html')).shadow$('#spreedly-number iframe[title="Card Number"]');
    await browser.switchToFrame(cardFrame);
    const textBox = await (await $('html')).shadow$('#card_number');
    await super.type(textBox, cardNumber);
    await browser.switchToParentFrame();
    const cvvFrame = await (await $('html')).shadow$('#spreedly-cvv iframe[title="CVV"]');
    await browser.switchToFrame(cvvFrame);
    const cvvTextBob = await (await $('html')).shadow$('#cvv');
    await super.type(cvvTextBob, cvvNumber);
    await browser.switchToParentFrame();
    await browser.switchToParentFrame();
    await super.selectByVisibleText(await (await $('html')).shadow$('select[name="Exp Month"]'), expMonth);
    await super.selectByVisibleText(await (await $('html')).shadow$('select[name="Exp Year"]'), expYear);
  }
}

export const creditCardComponent = new CreditCardComponent();
