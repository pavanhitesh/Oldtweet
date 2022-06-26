/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ItemDetailPage extends WebPage {
  get pageheader() {
    return $('[data-id="subHeaderTitle"]');
  }
}

export const profilePage = new ItemDetailPage();
