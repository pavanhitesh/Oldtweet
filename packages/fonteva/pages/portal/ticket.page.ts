/* eslint-disable class-methods-use-this */
import { Fields$EventApi__Ticket_Type__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { WebPage } from '../../../../globals/web/web.page';

class TicketPage extends WebPage {
  get continue() {
    return $('//button[@data-name="nextStep"]');
  }

  get cancelOrder() {
    return $('//button[text()="Cancel Order"]');
  }

  get confirmOrder() {
    return $('//button[@data-label= "Confirm Order"]');
  }

  get attendeeModal() {
    return $('#initTest');
  }

  get continueAttendeeSetup() {
    return $('[name="continueAttendeeSetup"]');
  }

  get registrationSuccessfulText() {
    return $('#registrationSuccessful');
  }

  get enterTheCityName() {
    return $('[data-name="Enter the city name-input"]>input');
  }

  get ticketPage() {
    return $('//div[@id="registrationContainer"]');
  }

  private ticketName!: string;

  get ticketId() {
    return this.ticketName;
  }

  set ticketId(ticketId: string) {
    this.ticketName = `//div[contains(@id,'${ticketId}')] //select`;
  }

  get ticket() {
    return $(this.ticketId);
  }

  get subtotalPrice() {
    return $(`[data-name="subTotalPrice"]`);
  }

  get summaryContactName() {
    return $(`.fonteva-event_summary .slds-m-right--medium.slds-align-bottom.fonteva-slds-text strong`);
  }

  getSummaryTicketByName(name: string) {
    return $(`//div[contains(@class,'fonteva-event_summary')]//*[text()='${name}']`);
  }

  async selectTicket(ticketName: string, quantity: number) {
    const ticketId = (
      await conn.query<Fields$EventApi__Ticket_Type__c>(
        `SELECT Id FROM EventApi__Ticket_Type__c WHERE Name ='${ticketName}' and EventApi__Event__c='${await browser.sharedStore.get(
          'eventId',
        )}'`,
      )
    ).records[0].Id;
    this.ticketId = ticketId;
    await super.selectByVisibleText(await this.ticket, quantity.toString());
  }

  get save() {
    return $('//button[@data-label="Save"]');
  }
}
export const ticketPage = new TicketPage();
