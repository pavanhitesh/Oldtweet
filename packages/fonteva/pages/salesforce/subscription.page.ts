/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class SusbcriptionPage extends WebPage {
  get header() {
    return $('//div[text() ="Subscription"]');
  }

  get status() {
    return $('html').$('//button[@title="Edit Status"]');
  }

  get Save() {
    return $('//button[@name="SaveEdit"]');
  }

  get renew() {
    return $('//button[text()="Renew"]');
  }
}
export const subscriptionPage = new SusbcriptionPage();
