/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class ItemFormPage extends WebPage {
  get addToCart() {
    return $('//button[@data-name="next"]');
  }

  get VenueFeedback() {
    return $('//div[@data-name="Please give us your feedback on the venue.-input"]/input');
  }

  get enterTheCityName() {
    return $('//div[@data-name="Enter the city name-input"]/input');
  }
}

export const itemFormPage = new ItemFormPage();
