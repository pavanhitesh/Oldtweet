/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class SusbcriptionLinePage extends WebPage {
  get header() {
    return $('//div[text() ="Subscription Line"]');
  }
}
export const subscriptionLinePage = new SusbcriptionLinePage();
