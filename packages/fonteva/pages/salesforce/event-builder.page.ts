/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class EventBuilderPage extends WebPage {
  get pageHeader() {
    return $(`//h1[@data-name='Event_Builder_Heading' and text() = 'Event Builder']`);
  }

  get eventInfo() {
    return $(`//div[@data-name='builderSidebar']//span[text()='Event Info']`);
  }

  get eventStartDate() {
    return $(`//div[@data-name='startDate']//input`);
  }

  get eventStartHour() {
    return $(`//div[@data-name='startHour']//select`);
  }

  get eventStartMinute() {
    return $(`//div[@data-name='startMin']//select`);
  }

  get eventStartAMPM() {
    return $(`//div[@data-name='start12hr']//select`);
  }

  get eventEndDate() {
    return $(`//div[@data-name='endDate']//input`);
  }

  get eventEndHour() {
    return $(`//div[@data-name='endHour']//select`);
  }

  get eventEndMinute() {
    return $(`//div[@data-name='endMin']//select`);
  }

  get eventEndAMPM() {
    return $(`//div[@data-name='end12hr']//select`);
  }

  get eventDurationYears() {
    return $(`//span[contains(text(),'Duration')]/following-sibling::span/span[1]`);
  }

  get eventDurationMonths() {
    return $(`//span[contains(text(),'Duration')]/following-sibling::span/span[2]`);
  }

  get eventDurationDays() {
    return $(`//span[contains(text(),'Duration')]/following-sibling::span/span[3]`);
  }

  get eventDurationHours() {
    return $(`//span[contains(text(),'Duration')]/following-sibling::span/span[4]`);
  }

  get newEvent() {
    return $('//a[@title="New"]');
  }

  get inputEventName() {
    return $('//div[@data-name="eventObjCloneName"]/input');
  }

  get startDate() {
    return $('//div[@data-name="startDate"]//input');
  }

  get searchEventName() {
    return $('//div[@data-name="cloneEventName"]//input');
  }

  get eventCategory() {
    return $('//div[@data-name="cloneCategoryName"]//select');
  }

  get cloneEventHeader() {
    return $('//div[@data-name="cloneEventTitle"]');
  }

  get continueClone() {
    return $('//button[@data-name="cloneContinueModal"]');
  }

  get finishClone() {
    return $('//button[@data-name="finishCloneModal"]');
  }

  get eventName() {
    return $('//slot[@name="primaryField"]//lightning-formatted-text');
  }

  async selectEventCategory(eventCategory: string) {
    await super.selectByVisibleText(await this.eventCategory, eventCategory);
  }
}

export const eventBuilderPage = new EventBuilderPage();
