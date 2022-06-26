/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class CompanyInfoPage extends WebPage {
  private changeFieldSetLocator!: string;

  private saveFieldSetLocator!: string;

  set fieldSetToEdit(fieldSetTitle: string) {
    this.changeFieldSetLocator = `//button[@data-name="change_my_info" and @aria-label='Change ${fieldSetTitle}']`;
  }

  get change() {
    return $(this.changeFieldSetLocator);
  }

  get annualRevenueInput() {
    return $(`//div[@data-name="AnnualRevenue-input"]/input`);
  }

  set fieldSetToSave(fieldSetTitle: string) {
    this.saveFieldSetLocator = `//div[@data-aura-class="LTECardHeader" and contains(.,'${fieldSetTitle}')]/following::button[@data-name='saveBtn']`;
  }

  get save() {
    return $(this.saveFieldSetLocator);
  }

  get annualRevenueValue() {
    return $(`//div[@data-field="AnnualRevenue"]//span[@class='currencyInputSpan']`);
  }
}

export const myCompanyInfoPage = new CompanyInfoPage();
