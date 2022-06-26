/* eslint-disable class-methods-use-this */
import tryCatch from 'await-to-js';
import { WebPage } from '../../../../../globals/web/web.page';

class AddressComponent extends WebPage {
  get buttonContinue() {
    return $('(//button[@data-name="useShipping"])[1]');
  }

  get textCreatedAddress() {
    return $('(//div[@data-name="know-addresses-text"])[1]');
  }

  get buttonCreateAddress() {
    return $(
      '//div[@data-name="shippingAddressContent"]//div[@data-name="Items_Need_To_Be_Taxed" or @data-name="Items_Need_To_Be_Shipped"]/following-sibling::div/button[@data-name="createAddressButton"]',
    );
  }

  get buttonNewAddress() {
    return $('button[data-name="addressCreateButton"]');
  }

  get textBoxNewAddressName() {
    return $('(//div[@data-name="name"]/input)[1]');
  }

  get selectTypeOfAddress() {
    return $('(//select[@name="Type"])[1]');
  }

  get checkBoxManuallAddress() {
    return $('(//label[@data-name="manualAddress"]/input)[1]');
  }

  get textBoxAddress() {
    return $('(//input[@placeholder="Enter your address"])[1]');
  }

  get selectAddress() {
    return $$('div.selectize-dropdown div span');
  }

  get buttonSaveAddress() {
    return $('(//button[@data-name="ka_modal_save"])[1]');
  }

  async addNewAddress(name: string, type: string, address: string) {
    await this.clickButtonNewAddress();

    await super.type(await this.textBoxNewAddressName, name);
    await super.selectByVisibleText(await this.selectTypeOfAddress, type);
    await super.click(await this.textBoxAddress);
    await super.slowTypeFlex(await this.textBoxAddress, address);
    await browser.keys('Enter');
    await browser.pause(2000);
    await super.click(await this.buttonSaveAddress);
    await super.waitForPresence(await this.textCreatedAddress);
    const addressValue = await super.getText(await this.textCreatedAddress);
    return addressValue;
  }

  async clickButtonNewAddress() {
    await super.click(await this.buttonCreateAddress);
    const isButtonExists = super.waitForPresence(await this.textBoxNewAddressName);
    const [isButtonExistsErr] = await tryCatch(isButtonExists);
    if (isButtonExistsErr) await super.click(await this.buttonCreateAddress);
  }
}

export const addressComponent = new AddressComponent();
