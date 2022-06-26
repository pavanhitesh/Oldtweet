import { Before, Then, Given, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$Contact,
  Fields$EventApi__Event__c,
  Fields$EventApi__Attendee__c,
  Fields$LTE__Site__c,
} from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { invitationPage } from '../../pages/portal/invitation.page';
import { ticketPage } from '../../pages/portal/ticket.page';
import { primaryAttendeeModalPage } from '../../pages/portal/primary-attendee-ticket-modal.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29213' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29213' }, async () => {
  const deleteAttendee = await conn.sobject('EventApi__Attendee__c').destroy(state.attendeeId);
  expect(deleteAttendee.success).toEqual(true);
});

Given(
  'User should be able to create an attendee of {string} status for {string} event with {string} contact',
  async (status: string, eventName: string, contactName: string) => {
    const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${contactName}'`))
      .records[0].Id;
    await browser.sharedStore.set('inviteeContactName', contactName);
    const eventId = (
      await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE
      EventApi__Display_Name__c='${eventName}'`)
    ).records[0].Id;
    const createInviteeBody = `EventApi__Attendee__c attendee = New EventApi__Attendee__c(); 
    attendee.EventApi__Attendee_Event__c = '${eventId}';
    attendee.EventApi__Contact__c = '${contactId}';
    attendee.EventApi__Status__c  = '${status}';
    Insert attendee;`;
    const response = await conn.tooling.executeAnonymous(createInviteeBody);
    expect(response.success).toEqual(true);
  },
);

Then(
  'User should be able to navigate to {string} event invitation url for {string} event',
  async (eventType: string, eventName: string) => {
    const portalURL = (
      await conn.query<Fields$LTE__Site__c>(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`)
    ).records[0].LTE__Site_URL__c;
    const eventId = (
      await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE
    EventApi__Display_Name__c='${eventName}'`)
    ).records[0].Id;
    await browser.sharedStore.set('eventId', eventId);
    state.attendeeId = (
      await conn.query<Fields$EventApi__Attendee__c>(
        `SELECT Id FROM EventApi__Attendee__c WHERE EventApi__Attendee_Event__c = '${eventId}' AND EventApi__Full_Name__c = '${await browser.sharedStore.get(
          'inviteeContactName',
        )}'`,
      )
    ).records[0].Id;
    if (eventType === 'lightning') {
      await browser.url(`${portalURL}/lt-event?attendee=${state.attendeeId}&id=${eventId}`);
    } else {
      await browser.url(`${portalURL}/community-event?attendee=${state.attendeeId}&id=${eventId}`);
    }
    await loginPage.waitForClickable(await invitationPage.accept);
    expect(await invitationPage.navbarAccept.isDisplayed()).toBe(true);
  },
);

Then(
  'User selects 1 ticket of each {string} {string} and verify the tickets are displayed on invitee modal',
  async (ticket1: string, ticket2: string) => {
    await invitationPage.click(await invitationPage.accept);
    await invitationPage.waitForClickable(await ticketPage.cancelOrder);
    await ticketPage.selectTicket(ticket1, 1);
    await ticketPage.selectTicket(ticket2, 1);
    await ticketPage.click(await ticketPage.continue);
    await invitationPage.waitForClickable(await primaryAttendeeModalPage.save);
    expect(await primaryAttendeeModalPage.primaryAttendeeTicket.getText()).toContain(ticket1);
    expect(await primaryAttendeeModalPage.primaryAttendeeTicket.getText()).toContain(ticket2);
  },
);
