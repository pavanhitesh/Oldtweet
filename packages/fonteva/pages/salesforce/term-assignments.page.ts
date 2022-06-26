/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class TermAssignmentsPage extends WebPage {
  private contactNameSuggestion!: string;

  get newButton() {
    return $('//a[@title="New" and contains(.,"New")]');
  }

  get contact() {
    return $('//input[contains(@placeholder,"Search Contacts")]');
  }

  set contactName(contactName: string) {
    this.contactNameSuggestion = `//ul/li//lightning-base-combobox-item[contains(.,'${contactName}')]`;
  }

  get contactNameOption() {
    return $(this.contactNameSuggestion);
  }

  get save() {
    return $('//button[@name="SaveEdit" and text()="Save"]');
  }

  get maxAssignmentsAlert() {
    return $(`//label[contains(.,'Is Active')]/following-sibling::div[@role='alert']`);
  }
}
export const termAssignmentsPage = new TermAssignmentsPage();
