/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class FormPage extends WebPage {
  private multiPickList!: string;

  private fieldName!: string;

  get newEntryButton() {
    return $(`//*[@class='slds-button slds-button_brand']`);
  }

  get multiEntryModal() {
    return $('//*[@id="modalnewMultiEntryModal"]/div');
  }

  get addEntryButton() {
    return $(`//button[@aria-label='Add Entry']`);
  }

  get addNewEntryButton() {
    return $(`//button[@type="button" and text()='New Entry']`);
  }

  get deleteEntry() {
    return $(`//div[@class="pfm-multi-entry-delete pfm-cursor_pointer"]`);
  }

  get isAuthorizedUserCheckBox() {
    return $(
      `//div[@id="modalnewMultiEntryModal"]//div[@class="slds-modal__container"]//label[@data-name="is authorized user-input"]/span[contains(@class,'checkbox')]`,
    );
  }

  get isAuthorizedUserCheckBoxValue() {
    return $(
      `//div[@id="modalnewMultiEntryModal"]//div[@class="slds-modal__container"]//label[@data-name="is authorized user-input"]/input`,
    );
  }

  get isAuthorizedUserValue() {
    return `//td[@id="is authorized user"]`;
  }

  get editMultiEntryRecord() {
    return `//div[contains(@class, 'multi-entry-edit')]`;
  }

  get fieldGroup() {
    return $(`//div[@data-name="fieldGroup"]`);
  }

  get multiEntrySummariesList() {
    return this.fieldGroup.$$(`//div[@class="pfm-multi-entry-summaries"]/div`);
  }

  get name() {
    return $('//div[@data-name="formName"]');
  }

  get submit() {
    return $('//button[@data-label = "Submit"]');
  }

  set inputForAccount(value: string) {
    this.fieldName = `//div[@data-label='${value}']/input`;
  }

  get inputforAccountDetails() {
    return $(this.fieldName);
  }

  set textAreaInputForAccount(value: string) {
    this.fieldName = `//div[@data-label='${value}']/textarea`;
  }

  get textAreaInputForAccountDetails() {
    return $(this.fieldName);
  }

  set dateError(value: string) {
    this.fieldName = `//c-pfm-input-date[@data-label='${value}']//div[@class='slds-form-element__help']`;
  }

  get dateErrorDetails() {
    return $(this.fieldName);
  }

  get multipicklist() {
    return $(
      `//div[@class="slds-modal slds-modal_small LTELTEModal slds-fade-in-open"]//div[@data-name="Multipicklist-input"]//button`,
    );
  }

  get picklist() {
    return $(
      `//div[@class="slds-modal slds-modal_small LTELTEModal slds-fade-in-open"]//div[@data-name="Picklist-input"]//select`,
    );
  }

  set multiPickListValue(value: string) {
    this.multiPickList = `//div[@class="slds-modal slds-modal_small LTELTEModal slds-fade-in-open"]//p[text()='${value}']`;
  }

  get multiPickListOption() {
    return $(this.multiPickList);
  }

  get checkbox() {
    return $(
      `//div[@class="slds-modal slds-modal_small LTELTEModal slds-fade-in-open"]//label[@data-name="Checkbox-input"]/span[contains(@class,'checkbox')]`,
    );
  }

  get editEntry() {
    return $(`//div[@class='pfm-multi-entry-edit pfm-cursor_pointer']`);
  }

  get saveEntry() {
    return $(`//button[@aria-label='Save Entry']`);
  }

  get fieldGroupInstructions() {
    return $(`//div[@data-name='fieldGroupInstructions']//span`);
  }

  set inputForContact(value: string) {
    this.fieldName = `//div[@class="slds-modal slds-modal_small LTELTEModal slds-fade-in-open"]//div[@data-name='${value}-input']/input`;
  }

  get inputforContactDetails() {
    return $(this.fieldName);
  }

  set contactSummary(value: string) {
    this.fieldName = `//td[@id='${value}']`;
  }

  get contactSummaryDetails() {
    return $(this.fieldName);
  }

  set dateTime(value: string) {
    this.fieldName = `(//div[@data-label='${value}']//input)[1]`;
  }

  get dateTimeDetails() {
    return $(this.fieldName);
  }

  set birthDate(value: string) {
    this.fieldName = `//c-pfm-input-date[@data-label='${value}']//input`;
  }

  get birthDateDetails() {
    return $(this.fieldName);
  }

  set error(value: string) {
    this.fieldName = `//div[@data-label='${value}']//li[@class='form-element__help']`;
  }

  get errorMessage() {
    return $(this.fieldName);
  }

  set formButton(value: string) {
    this.fieldName = `//div[@data-label='${value}']//button`;
  }

  get formButtonDetails() {
    return $(this.fieldName);
  }

  set multiPicklistOption(value: string) {
    this.multiPickList = `//p[text()='${value}']`;
  }

  get multiPicklistOptions() {
    return $(this.multiPickList);
  }

  set formSelect(value: string) {
    this.fieldName = `//div[@data-label='${value}']//select`;
  }

  get formSelectDetails() {
    return $(this.fieldName);
  }

  set formInformationalText(value: string) {
    this.fieldName = `//div[@data-name='fieldGroup']//div[text()='${value}']`;
  }

  get formInformationalTextDetails() {
    return $(this.fieldName);
  }

  set formlabelElement(value: string) {
    this.fieldName = `//label[@data-label='${value}']`;
  }

  get formlabelElementDetails() {
    return $(this.fieldName);
  }

  set errorLabelElement(value: string) {
    this.fieldName = `//label[@data-label='${value}']//li`;
  }

  get errorLabelElementDetails() {
    return $(this.fieldName);
  }

  async fillMultiEntryFormEmail(email: string) {
    await super.click(await this.newEntryButton);
    await super.isDisplayed(await this.newEntryButton);
    expect(await this.multiEntryModal.isDisplayed()).toEqual(true);
    this.inputForAccount = `Email`;
    await super.type(await this.inputforAccountDetails, email);
    await super.click(await this.addEntryButton);
  }

  async editMultiEntryRecordByIsAuthorizedUser() {
    (await Promise.all(await this.multiEntrySummariesList)).forEach(async (item) => {
      if ((await super.getText(await item.$(this.isAuthorizedUserValue))) === 'true') {
        await super.click(await item.$(this.editMultiEntryRecord));
        await super.waitForPresence(await this.isAuthorizedUserCheckBox);
      }
    });
  }
}

export const formPage = new FormPage();
