/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class DocumentPage extends WebPage {
  get subTotalValue() {
    return $(`//c-pfm-output-field[@data-value="subtotalValue"]//span[contains(@class,'currency')]`);
  }

  get totalValue() {
    return $(`//c-pfm-output-field[@data-value="totalValue"]//span[contains(@class,'currency')]`);
  }
}
export const documentPage = new DocumentPage();
