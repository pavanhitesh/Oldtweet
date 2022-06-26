import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import {
  Fields$EventApi__Attendee__c,
  Fields$EventApi__Registration_Group__c,
  Fields$PagesApi__Field_Response__c,
} from 'packages/fonteva/fonteva-schema';
import { attendeeModalPage } from '../../pages/portal/attendee-modal.page';
import { ticketPage } from '../../pages/portal/ticket.page';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

After({ tags: '@TEST_PD-29121' }, async () => {
  const deleteAttendee0 = await conn.sobject('EventApi__Attendee__c').destroy(localSharedData.attendee0);
  expect(deleteAttendee0.success).toEqual(true);
  const deleteAttendee1 = await conn.sobject('EventApi__Attendee__c').destroy(localSharedData.attendee1);
  expect(deleteAttendee1.success).toEqual(true);
  const registrationGroupId = (
    await conn.query<Fields$EventApi__Registration_Group__c>(
      `SELECT Id FROM EventApi__Registration_Group__c WHERE EventApi__Event__c = '${await browser.sharedStore.get(
        'eventId',
      )}'`,
    )
  ).records[0].Id;
  const deleteGroup = await conn.destroy('EventApi__Registration_Group__c', registrationGroupId as string);
  expect(deleteGroup.success).toEqual(true);
});

Then(
  'User register for {string} ticket with {int} quantity and with form and group ticket',
  async (ticket: string, quantity: number) => {
    await eventRegistrationPage.click(await eventRegistrationPage.registerEvent);
    await ticketPage.waitForPresence(await ticketPage.continue);
    await ticketPage.selectTicket(ticket, quantity);
    await ticketPage.click(await ticketPage.continue);
    localSharedData.city0 = faker.address.cityName();
    localSharedData.city1 = faker.address.cityName();
    await attendeeModalPage.type(await attendeeModalPage.city, localSharedData.city0);
    await attendeeModalPage.click(await attendeeModalPage.continue);
    await attendeeModalPage.type(await attendeeModalPage.city, localSharedData.city1);
    await attendeeModalPage.click(await attendeeModalPage.continue);
    await attendeeModalPage.waitForPresence(await attendeeModalPage.registrationSuccess);
    expect(await attendeeModalPage.isDisplayed(await attendeeModalPage.registrationSuccess)).toEqual(true);
  },
);

Then('User verifies registration form data is available in all attendee record', async () => {
  const attendee = (
    await conn.query<Fields$EventApi__Attendee__c>(
      `Select Id from EventApi__Attendee__c where EventApi__Attendee_Event__c ='${await browser.sharedStore.get(
        'eventId',
      )}'`,
    )
  ).records;
  localSharedData.attendee0 = attendee[0].Id as string;
  localSharedData.attendee1 = attendee[1].Id as string;
  expect(attendee.length).toEqual(2);
  const formResponse = (
    await conn.query<Fields$PagesApi__Field_Response__c>(
      `Select PagesApi__Response__c from PagesApi__Field_Response__c where PagesApi__Form_Response__c IN 
      (Select Id from PagesApi__Form_Response__c where EventApi__Attendee__c = '${attendee[0].Id}' 
      OR EventApi__Attendee__c = '${attendee[1].Id}')`,
    )
  ).records;
  expect(formResponse.length).toEqual(2);
  expect(formResponse[0].PagesApi__Response__c).toEqual(localSharedData.city0);
  expect(formResponse[1].PagesApi__Response__c).toEqual(localSharedData.city1);
});
