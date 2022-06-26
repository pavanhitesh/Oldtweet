/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class AgendaPage extends WebPage {
  private scheduleItem!: string;

  get continue() {
    return $('//button[@data-name="nextStep"]');
  }

  get agendaLink() {
    return $('//a[@data-name="agenda"]');
  }

  get scheduleItemSearch() {
    return $(`//label[text() ="Schedule Item Search"]/parent::div//input`);
  }

  set scheduleItemName(scheduleItem: string) {
    this.scheduleItem = scheduleItem;
  }

  get scheduleItemPriceDisplayed() {
    return $(`//div[text()='${this.scheduleItem}']//parent::div//parent::div/div//span[contains(@class,'currency')]`);
  }

  get addScheduleItemButton() {
    return $(`//div[text()='${this.scheduleItem}']//parent::div//parent::div/div//button[text()="Add"]`);
  }

  get scheduleItemPriceDisplayedInSummary() {
    return $(`//div[@data-label="${this.scheduleItem}"]/strong/span[contains(@class,'currency')]`);
  }

  get cancelOrder() {
    return $(`//button[text()='Cancel Order']`);
  }
}
export const agendaPage = new AgendaPage();
