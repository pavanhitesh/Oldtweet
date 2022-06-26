/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class AttendeeModalPage extends WebPage {
  private attendeeTicketId!: string;

  private attendeeToSelectNumber!: string;

  private searchSuggestionAttendeeId!: string;

  get city() {
    return $('//div[@data-name="Enter the city name-input"]/input');
  }

  get registrationSuccess() {
    return $('#registrationSuccessful');
  }

  get continue() {
    return $('//button[@data-name="continueAttendeeSetup"]');
  }

  set attendeeSection(itemName: string) {
    this.attendeeTicketId = `//div[@id="${itemName}"]/div`;
  }

  set attendeeNumber(attendeeNumber: number) {
    this.attendeeToSelectNumber = `//div[@data-index='${attendeeNumber}']`;
  }

  get attendeeToSelect() {
    return $(this.attendeeTicketId).$(this.attendeeToSelectNumber);
  }

  get attendeeSearchbox() {
    return $(`//div[@data-label="Search Attendee"]`);
  }

  get attendeeSearchInput() {
    return $(`//div[@data-label="Search Attendee"]//input`);
  }

  set attendeeIdSuggestion(attendeeId: string) {
    this.searchSuggestionAttendeeId = `//div[@data-value="${attendeeId}"]`;
  }

  get attendeeSuggestionOption() {
    return $(this.searchSuggestionAttendeeId);
  }
}
export const attendeeModalPage = new AttendeeModalPage();
