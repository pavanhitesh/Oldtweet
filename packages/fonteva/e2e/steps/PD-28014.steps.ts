/* eslint-disable prefer-destructuring */
import { After, Given } from '@cucumber/cucumber';
import * as faker from 'faker';
import {
  Fields$EventApi__Attendee__c,
  Fields$PagesApi__Field_Response__c,
  Fields$PagesApi__Form_Response__c,
} from 'packages/fonteva/fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';

const state: { [key: string]: string | number | boolean } = {};

Given(
  'User enters {string} date on the form and register for the event as {string}',
  async (date: string, user: string) => {
    if (user === 'guest user') {
      state.guestName = `${faker.name.firstName()} ${faker.name.lastName()}`;
      await eventRegistrationPage.slowTypeFlex(await eventRegistrationPage.searchAttendee, state.guestName);
      await browser.keys('Enter');
      await eventRegistrationPage.slowTypeFlex(
        await eventRegistrationPage.attendeeEmail,
        `${faker.name.firstName()}@mailinator.com`,
      );
    }
    state.date = date;
    await eventRegistrationPage.slowTypeFlex(await eventRegistrationPage.formDate, date);
    await browser.keys('Tab');
    await eventRegistrationPage.click(await eventRegistrationPage.registerNow);
    await eventRegistrationPage.waitForAbsence(await eventRegistrationPage.registerNow);
    expect(await eventRegistrationPage.registerNow.isDisplayed()).toEqual(false);
  },
);

Given('User verifies the {string} form response for {string}', async (form: string, user: string) => {
  let attendeeInfo;
  if (user === 'guest user') {
    attendeeInfo = (
      await conn.query<Fields$EventApi__Attendee__c>(
        `Select Id, EventApi__Registration_Group__c from EventApi__Attendee__c where EventApi__Attendee_Event__c = '${await browser.sharedStore.get(
          'eventId',
        )}' and EventApi__Contact__r.Name = '${state.guestName}'`,
      )
    ).records[0];
  } else {
    attendeeInfo = (
      await conn.query<Fields$EventApi__Attendee__c>(
        `Select Id, EventApi__Registration_Group__c from EventApi__Attendee__c where EventApi__Attendee_Event__c = '${await browser.sharedStore.get(
          'eventId',
        )}' and EventApi__Contact__c = '${await browser.sharedStore.get('contactId')}'`,
      )
    ).records[0];
  }

  state.attendeeId = attendeeInfo.Id as string;
  state.attendeeRegistrationGroup = attendeeInfo.EventApi__Registration_Group__c as string;

  state.formResponseId = (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${form}' AND EventApi__Attendee__c = '${state.attendeeId}'`,
    )
  ).records[0].Id;
  const formFieldResponse = (
    await conn.query<Fields$PagesApi__Field_Response__c>(
      `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${state.formResponseId}'`,
    )
  ).records[0].PagesApi__Response__c;
  expect(formFieldResponse).toEqual(state.date);
});

After({ tags: '@TEST_PD-29250' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(state.formResponseId as string);
  expect(deleteFormResponse.success).toEqual(true);
  const deleteAttendee = await conn.destroy('EventApi__Attendee__c', state.attendeeId as string);
  expect(deleteAttendee.success).toEqual(true);
  const deleteEventRegGroup = await conn.destroy(
    'EventApi__Registration_Group__c',
    state.attendeeRegistrationGroup as string,
  );
  expect(deleteEventRegGroup.success).toEqual(true);
});

After({ tags: '@TEST_PD-29182' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(state.formResponseId as string);
  expect(deleteFormResponse.success).toEqual(true);
  const deleteAttendee = await conn.destroy('EventApi__Attendee__c', state.attendeeId as string);
  expect(deleteAttendee.success).toEqual(true);
  const deleteEventRegGroup = await conn.destroy(
    'EventApi__Registration_Group__c',
    state.attendeeRegistrationGroup as string,
  );
  expect(deleteEventRegGroup.success).toEqual(true);
});
