/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ItemRenewalFormPage extends WebPage {
  get rating() {
    return $('//div[@data-name="Rating-input"]/input');
  }

  get continue() {
    return $('//button[@data-name="renewFormContinueBtn"]');
  }

  get change() {
    return $('//div[contains(@class,"pfm-form_summary")]//a[text()="Change"]');
  }
}

export const itemRenewalFormPage = new ItemRenewalFormPage();
