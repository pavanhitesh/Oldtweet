/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ApplyPaymentPage extends WebPage {
  get backEndContainer() {
    return $(`div#backendContainer`);
  }

  get applyPayment() {
    return $('//div[@id="backendContainer"]//c-pfm-button[@data-name="applyPaymentButton"]/button');
  }

  get availableCredit() {
    return $('//c-pfm-output-field[@data-name="totalAvailableCredit"]//c-pfm-currency/span');
  }

  get receiptHeader() {
    return $(`//h1[contains(.,'Receipt')]`);
  }

  get paymentTypeDropDownApplyPayemntPage() {
    return $(`//div[@id='backendContainer']//select[@aria-label='Payment Type']`);
  }

  get orderDetailsTableApplyPaymentPage() {
    return $(`//c-pfm-table[@data-name='selectedOrderLinesTable']//table//tbody`);
  }

  get openOrderDetailsIconApplyPaymentPage() {
    return $(`//tbody//tr[1]//c-pfm-button[contains(@data-name,'openDrawer')]/button/lightning-icon`);
  }

  get orderDetailsTableRow() {
    return $('//c-pfm-table[@data-name="orderInfoTable"]//tbody/tr');
  }

  get orderDetailsTableBalanceDue() {
    return $(
      `//c-pfm-table[@data-name="orderInfoTable"]//td[@data-label="Balance Due"]//span[@class="currencyInputSpan"]`,
    );
  }

  get orderDetailsTableCurrentDue() {
    return $(
      `//c-pfm-table[@data-name="orderInfoTable"]//td[@data-label="Current Due"]//span[@class="currencyInputSpan"]`,
    );
  }

  get applyPaymentPageHeader() {
    return $(`//h3[contains(.,'Apply Payment')]`);
  }

  get orderInfoHeaderApplyPaymentPage() {
    return $(`//c-pfm-text[@data-name="orderInfoHeader"]/p[contains(.,'Order Information')]`);
  }

  get selectPaymentType() {
    return $('//div[@id="backendContainer"]//*[@data-name="paymentType"]//select');
  }

  get creditCard() {
    return $('#card_number');
  }

  get cvv() {
    return $('#cvv');
  }

  get processPayment() {
    return $('//*[@data-name="processPaymentBtn"]//button');
  }

  get optionalAddressText() {
    return $('//div[text()="Address is optional."]');
  }

  get textForNoAddress() {
    return $('//div[text()="No address found. Please create a new address to process payment."]');
  }

  get businessGroupName() {
    return $('//c-pfm-text[@data-name="businessGroupName"]');
  }

  get newAddress() {
    return $(`//c-known-address[@data-name='knownAddressComp']//c-pfm-button[@data-name='new_known_address']/button`);
  }

  get addressName() {
    return $(`//c-known-address-modal[@data-name="knownAddressModal"]//lightning-input[@data-label='Name']//input`);
  }

  get addressType() {
    return $(
      `//c-known-address-modal[@data-name="knownAddressModal"]//c-pfm-input-picklist[@data-label="Type"]//select`,
    );
  }

  get addressStreet() {
    return $(`//c-known-address-modal[@data-name="knownAddressModal"]//textarea[@name='street']`);
  }

  get addressCity() {
    return $(`//c-known-address-modal[@data-name="knownAddressModal"]//input[@name='city']`);
  }

  get addressState() {
    return $(`//c-known-address-modal[@data-name="knownAddressModal"]//input[@name='province']`);
  }

  get addressPostalCode() {
    return $(`//c-known-address-modal[@data-name="knownAddressModal"]//input[@name='postalCode']`);
  }

  get saveAddress() {
    return $(`//c-known-address-modal[@data-name="knownAddressModal"]//c-pfm-button[@data-name="saveButton"]`);
  }

  get batchInput() {
    return $(`//c-pfm-input[@data-name='batchLookup']//input`);
  }

  private batchSuggestionOption!: string;

  get batchSuggestion() {
    return this.batchSuggestionOption;
  }

  set batchSuggestion(batchName: string) {
    this.batchSuggestionOption = `//div[@role='listbox']//span[text()='${batchName}']`;
  }

  get batchSuggestionOptionItem() {
    return $(this.batchSuggestion);
  }

  get depositAccountDropDown() {
    return $(`//select[@aria-label='Deposit Account']`);
  }

  async selectBatch(batchName: string) {
    await super.click(await this.batchInput);
    await super.slowTypeFlex(await this.batchInput, batchName);
    this.batchSuggestion = batchName;
    await super.click(await this.batchSuggestionOptionItem);
  }

  get creditAppliedAmountInput() {
    return $(`//input[@name='creditAppliedAbsolute']`);
  }

  get paymentAmountInput() {
    return $(`//input[@name='paymentAbsolute']`);
  }

  get balanceDueAmount() {
    return $(
      `//c-pfm-column[@data-name='orderInformationPaymentSummary']//c-pfm-output-field[@data-name='balanceDueAmount']//span[@class='currencyInputSpan']`,
    );
  }

  get creditAppliedAmount() {
    return $(
      `//c-pfm-column[@data-name='orderInformationPaymentSummary']//c-pfm-output-field[@data-name='creditAppliedAmount']//span[@class='currencyInputSpan']`,
    );
  }

  get remainingBalanceAmount() {
    return $(`//c-pfm-output-field[@data-name="remainingBalanceAmount"]//span[@class='currencyInputSpan']`);
  }

  get cancelButton() {
    return $(`//div[@id="backendContainer"]//slot[@name='header']//c-pfm-button[@data-name="closeButton"]/button`);
  }

  get paymentsApplied() {
    return $(`//slot[text()='Payment Applied']//following::span[@class='currencyInputSpan'][1]`);
  }

  async selectPaymentTypeInApplyPayment(paymentType: string) {
    await super.waitForPresence(await this.backEndContainer);
    const selectPaymentType = await (await this.backEndContainer).shadow$(`[data-name="paymentType"] select`);
    await super.selectByVisibleText(selectPaymentType, paymentType);
  }

  async typeReferenceNumber(refNumber: string) {
    await super.waitForPresence(await this.backEndContainer);
    const refNumberElement = await (await this.backEndContainer).shadow$(`[data-id="referenceNumber"] input`);
    await super.type(refNumberElement, refNumber);
  }

  async selectPaidAndPostDates(paymentDate: string, postDate: string) {
    await super.waitForPresence(await this.backEndContainer);
    await super.type(await (await this.backEndContainer).shadow$(`[data-id="paymentDate"] input`), paymentDate);
    await super.type(await (await this.backEndContainer).shadow$(`[data-id="postedDate"] input`), postDate);
  }

  async clickApplyPayments() {
    await super.click(await this.applyPayment);
    await super.waitForPresence(await this.receiptHeader);
  }

  async getFinalItemPriceApplyPaymentPage(itemName: string) {
    const orderDetailsTable = this.orderDetailsTableApplyPaymentPage;
    const itemPriceElement = await orderDetailsTable.$(
      `//td[@data-label='Name' and contains(.,'${itemName}')]/..//td[@data-label='Balance Due']`,
    );
    return parseInt((await super.getText(itemPriceElement)).replace('$', ''), 10);
  }

  async input(fieldInput: string, value: string) {
    await super.waitForClickable(await $(`//div[@id="backendContainer"]//input[@name="${fieldInput}"]`));
    await super.slowTypeFlex(await $(`//div[@id="backendContainer"]//input[@name="${fieldInput}"]`), value);
  }

  async addNewAddress(name: string, type: string, street: string, city: string, state: string, postalcode: string) {
    await (await this.newAddress).click();
    await super.waitForPresence(await this.addressName);
    await (await this.addressName).setValue(name);
    await super.selectByAttribute(await this.addressType, 'value', type);
    await (await this.addressStreet).setValue(street);
    await (await this.addressCity).setValue(city);
    await (await this.addressState).setValue(state);
    await (await this.addressPostalCode).setValue(postalcode);
    await (await this.saveAddress).click();
  }

  async creditCardPayment(name: string, CCNumber: string, CCcvv: string, CCMonth: string, CCYear: string) {
    await this.input('full_name', name);
    await super.waitForPresence(await (await $('html')).shadow$('iframe[title="Payment Form"]'));
    await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="Payment Form"]'));
    await browser.pause(3000);
    await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="Card Number"]'));
    await super.waitForPresence(await this.creditCard);
    await super.slowTypeFlex(await this.creditCard, CCNumber);
    await browser.switchToParentFrame();
    await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="CVV"]'));
    await super.type(await this.cvv, CCcvv);
    await browser.switchToParentFrame();
    await browser.switchToParentFrame();
    await super.selectByVisibleText(await (await $('html')).shadow$('select[aria-label="Exp Month"]'), CCMonth);
    await super.selectByVisibleText(await (await $('html')).shadow$('select[aria-label="Exp Year"]'), CCYear);
  }
}
export const applyPaymentPage = new ApplyPaymentPage();
