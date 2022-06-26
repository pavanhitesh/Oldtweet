import { WebPage } from '../../../../globals/web/web.page';
/* eslint-disable class-methods-use-this */
class KnownAddressPage extends WebPage {
  private editKnowAddressButton!: string;

  get newButton() {
    return $(`//a[@title="New"]`);
  }

  get addressListFrame() {
    return $(`//iframe[contains(@name,"vfFrame")]`);
  }

  get newAddressButton() {
    return $(`//button[@data-name="new-address"]`);
  }

  get enterManualAddressCheckBox() {
    return $(`//label[@data-name="manualAddress"]/span[contains(@class,"checkbox")]`);
  }

  get streetTextBox() {
    return $(`//div[@data-name="street_name"]/textarea`);
  }

  get countryDropDown() {
    return $(`//select[@name="Country"]`);
  }

  get stateDropDown() {
    return $(`//select[@name="State"]`);
  }

  get saveButton() {
    return $(`//button[@data-name="ka_modal_save"]`);
  }

  get countryErrorMessage() {
    return $(`//div[@data-name="country"]/ul/li`);
  }

  set editKnowAddressId(knownAddressId: string) {
    this.editKnowAddressButton = `//button[@data-id="${knownAddressId}"]//span[text()='Edit Address']/../../self::button`;
  }

  get editAddressButton() {
    return $(this.editKnowAddressButton);
  }
}

export const knownAddressPage = new KnownAddressPage();
