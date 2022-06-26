import { After, Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';
import { ticketPage } from '../../pages/portal/ticket.page';
import * as data from '../data/PD-28178.json';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$EventApi__Attendee__c } from '../../fonteva-schema';

Before({ tags: '@TEST_PD-28986' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User verifies summary and confirm order button after ordering {int} tickets of type {string}',
  async (quantity: number, ticket: string) => {
    await eventRegistrationPage.click(await eventRegistrationPage.registerEvent);
    await ticketPage.waitForPresence(await ticketPage.ticketPage);
    await ticketPage.selectTicket(ticket, quantity);
    await ticketPage.click(await ticketPage.confirmOrder);
    await ticketPage.waitForPresence(await ticketPage.attendeeModal);
    expect(await ticketPage.isDisplayed(await ticketPage.attendeeModal)).toEqual(true);
    await ticketPage.type(await ticketPage.enterTheCityName, data.attendeeCity);
    await ticketPage.click(await ticketPage.continueAttendeeSetup);
    await ticketPage.waitForPresence(await ticketPage.registrationSuccessfulText);
    expect(await ticketPage.isDisplayed(await ticketPage.registrationSuccessfulText)).toEqual(true);
  },
);

After({ tags: '@TEST_PD-28986' }, async () => {
  const attendeeInfo = (
    await conn.query<Fields$EventApi__Attendee__c>(
      `Select Id, EventApi__Registration_Group__c from EventApi__Attendee__c where EventApi__Attendee_Event__c = '${await browser.sharedStore.get(
        'eventId',
      )}' and EventApi__Contact__c = '${await browser.sharedStore.get('contactId')}'`,
    )
  ).records[0];
  const attendeeId = attendeeInfo.Id as string;
  const attendeeRegistrationGroup = attendeeInfo.EventApi__Registration_Group__c as string;
  const deleteAttendee = await conn.destroy('EventApi__Attendee__c', attendeeId as string);
  expect(deleteAttendee.success).toEqual(true);
  const deleteEventRegGroup = await conn.destroy(
    'EventApi__Registration_Group__c',
    attendeeRegistrationGroup as string,
  );
  expect(deleteEventRegGroup.success).toEqual(true);
});
