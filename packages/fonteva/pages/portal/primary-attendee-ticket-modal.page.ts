/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class PrimaryAttendeeModalPage extends WebPage {
  get header() {
    return $('//span[@slot="title"]');
  }

  get save() {
    return $('//c-pfm-modal[@data-name="primaryAttendeeModal"]//button[@name="saveButtonModal"]');
  }

  get close() {
    return $('//c-pfm-modal[@data-name="primaryAttendeeModal"]//button[@name="closeButtonModal"]');
  }

  get primaryAttendeeTicket() {
    return $('//c-pfm-modal[@data-name="primaryAttendeeModal"]//select');
  }
}
export const primaryAttendeeModalPage = new PrimaryAttendeeModalPage();
