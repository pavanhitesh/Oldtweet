/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ItemPriceRulesListPage extends WebPage {
  get newPriceRuleButton() {
    return $('//a[(@title = "New")]');
  }
}

export const itemPriceRulesListPage = new ItemPriceRulesListPage();
