import { Then, When, After } from '@cucumber/cucumber';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { conn } from '../../shared/helpers/force.helper';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';
import { ticketPage } from '../../pages/portal/ticket.page';
import { recommendedItemsPage } from '../../pages/portal/recommend-items.page';
import { agendaPage } from '../../pages/portal/agenda.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$EventApi__Attendee__c, Fields$PagesApi__Field_Response__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

When(
  'User enters the form response {string} after ordering {string} ticket of type {string}',
  async (formResponseValue: string, quantity: number, ticket: string) => {
    await eventRegistrationPage.click(await eventRegistrationPage.registerEvent);
    await ticketPage.sleep(MilliSeconds.XXS);
    await ticketPage.selectTicket(ticket, quantity);
    await ticketPage.click(await ticketPage.continue);
    await ticketPage.waitForPresence(await ticketPage.attendeeModal);
    expect(await ticketPage.isDisplayed(await ticketPage.attendeeModal)).toEqual(true);
    await ticketPage.type(await ticketPage.enterTheCityName, formResponseValue);
    await ticketPage.click(await ticketPage.continueAttendeeSetup);
    await agendaPage.click(await agendaPage.continue);
    await recommendedItemsPage.waitForPresence(await recommendedItemsPage.recommendeditemLink);
    await recommendedItemsPage.click(await recommendedItemsPage.continue);
    expect(await checkoutPage.isDisplayed(await checkoutPage.checkoutLink)).toEqual(true);
  },
);

Then(
  'User verifies the form response field is populated or updated with {string} for attendee record',
  async (formValue: string) => {
    localSharedData.attendeeId = (
      await conn.query<Fields$EventApi__Attendee__c>(
        `SELECT Id FROM EventApi__Attendee__c WHERE  EventApi__Sales_Order__c = '${await browser.sharedStore.get(
          'portalSO',
        )}'`,
      )
    ).records[0].Id;
    const formFieldResponse = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE EventApi__Attendee__c = '${localSharedData.attendeeId}'`,
      )
    ).records[0].PagesApi__Response__c;
    expect(formFieldResponse).toEqual(formValue);
  },
);

Then('User edits the order details and change the form resoponse value with {string}', async (formValue: string) => {
  await checkoutPage.click(await checkoutPage.continueToEvent);
  await ticketPage.sleep(MilliSeconds.XXXS);
  await eventRegistrationPage.click(await eventRegistrationPage.manageRegistration);
  await eventRegistrationPage.mouseHoverOver(await eventRegistrationPage.showMore);
  await eventRegistrationPage.click(await eventRegistrationPage.editOrderDetail);
  await ticketPage.type(await ticketPage.enterTheCityName, formValue);
  await ticketPage.click(await ticketPage.save);
  expect(await eventRegistrationPage.manageRegistration.isDisplayed()).toEqual(true);
});

After({ tags: '@TEST_PD-29368' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('portalSO')) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);
  const deleteAttendee = await conn.destroy('EventApi__Attendee__c', localSharedData.attendeeId as string);
  expect(deleteAttendee.success).toEqual(true);
});
