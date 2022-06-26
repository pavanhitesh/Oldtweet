/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ViewOrdersPage extends WebPage {
  get viewOrderHeading() {
    return $('//h3/slot[text()="Order View"]');
  }

  get copyOrderLink() {
    return $('//button[@aria-label="Copy Order Overview link"]');
  }
}

export const viewOrderPage = new ViewOrdersPage();
