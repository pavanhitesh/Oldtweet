/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../../globals/web/web.page';

/**
 * sub page containing specific selectors and methods for a specific page
 */
class HeaderComponent extends WebPage {
  get header() {
    return $('.slds-global-header');
  }

  get search() {
    return $(`//input[@placeholder='Search...']`);
  }
}
export const headerComponent = new HeaderComponent();
