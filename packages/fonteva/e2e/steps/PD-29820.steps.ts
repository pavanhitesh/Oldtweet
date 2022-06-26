import { After, Given } from '@cucumber/cucumber';
import * as faker from 'faker';
import {
  Fields$EventApi__Attendee__c,
  Fields$PagesApi__Field_Response__c,
  Fields$PagesApi__Form_Response__c,
} from 'packages/fonteva/fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';
import { formPage } from '../../pages/portal/form.page';

const localSharedData: { [key: string]: string | string } = {};

Given('User enter the attendee details and register for the event', async () => {
  localSharedData.firstName = faker.name.firstName();
  localSharedData.lastName = faker.name.lastName();
  localSharedData.contactNumber = faker.datatype.number({ min: 9000000000, max: 9999999999 }) as unknown as string;
  formPage.inputForAccount = 'First Name';
  await eventRegistrationPage.type(await formPage.inputforAccountDetails, localSharedData.firstName);
  formPage.inputForAccount = 'Last Name';
  await eventRegistrationPage.type(await formPage.inputforAccountDetails, localSharedData.lastName);
  formPage.inputForAccount = 'Contact Number';
  await eventRegistrationPage.type(await formPage.inputforAccountDetails, localSharedData.contactNumber);
  await eventRegistrationPage.click(await eventRegistrationPage.registerNow);
  await eventRegistrationPage.waitForAbsence(await eventRegistrationPage.registerNow);
  expect(await eventRegistrationPage.isDisplayed(await eventRegistrationPage.registerNow)).toEqual(false);
});

Given(
  'User verifies the responder {string} name and the form {string} response',
  async (contactName: string, form: string) => {
    const attendeeInfo = (
      await conn.query<Fields$EventApi__Attendee__c>(
        `Select Id, EventApi__Registration_Group__c from EventApi__Attendee__c where EventApi__Attendee_Event__c = '${await browser.sharedStore.get(
          'eventId',
        )}' and EventApi__Contact__c = '${await browser.sharedStore.get('contactId')}'`,
      )
    ).records[0];

    localSharedData.attendeeId = attendeeInfo.Id as string;
    localSharedData.attendeeRegistrationGroup = attendeeInfo.EventApi__Registration_Group__c as string;

    const formResponder = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT PagesApi__Responder_Link__c from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${form}' AND EventApi__Attendee__c = '${localSharedData.attendeeId}'`,
      )
    ).records[0].PagesApi__Responder_Link__c;
    expect(formResponder).toContain(contactName);

    localSharedData.formResponseId = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${form}' AND EventApi__Attendee__c = '${localSharedData.attendeeId}'`,
      )
    ).records[0].Id;
    const formFieldResponse = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${localSharedData.formResponseId}'`,
      )
    ).records[0].PagesApi__Response__c;
    expect(formFieldResponse).toEqual(String(localSharedData.contactNumber));
  },
);

After({ tags: '@TEST_PD-29821' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
  const deleteFormResponse = await conn
    .sobject('PagesApi__Form_Response__c')
    .destroy(localSharedData.formResponseId as string);
  expect(deleteFormResponse.success).toEqual(true);
  const deleteAttendee = await conn.destroy('EventApi__Attendee__c', localSharedData.attendeeId as string);
  expect(deleteAttendee.success).toEqual(true);
  const deleteEventRegGroup = await conn.destroy(
    'EventApi__Registration_Group__c',
    localSharedData.attendeeRegistrationGroup as string,
  );
  expect(deleteEventRegGroup.success).toEqual(true);
});
