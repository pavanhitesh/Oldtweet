/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class EventRegistrationPage extends WebPage {
  get registerEvent() {
    return $('//button[@data-name="registerButton"]');
  }

  get newAttendee() {
    return $('[data-name="newAttendee"]');
  }

  get manageRegistration() {
    return $('[data-name="manageRegistrationButton"]');
  }

  get ticketsEventTab() {
    return $('//a[@title="tickets"]');
  }

  get loginBtn() {
    return $('[data-name="loginBtn"]');
  }

  get notAMemberButton() {
    return $('.selfRegister');
  }

  get formDate() {
    return $('//div[@data-name="DateForm"]//input');
  }

  get registerNow() {
    return $('//button[text() ="Register Now"]');
  }

  get searchAttendee() {
    return $('//div[@data-name="contactId"]//input');
  }

  get attendeeEmail() {
    return $('//div[@data-name="email"]//input');
  }

  get showMore() {
    return $('//button[@aria-label="Show More"]');
  }

  get editOrderDetail() {
    return $('//span[text()="Edit Order Detail"]');
  }
}

export const eventRegistrationPage = new EventRegistrationPage();
