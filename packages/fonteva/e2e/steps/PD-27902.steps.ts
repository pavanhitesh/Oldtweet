import { After, Then } from '@cucumber/cucumber';
import {
  Fields$EventApi__Attendee__c,
  Fields$OrderApi__Payment_Method__c,
  Fields$OrderApi__Receipt__c,
} from '../../fonteva-schema';
import { agendaPage } from '../../pages/portal/agenda.page';
import { addressComponent } from '../../pages/portal/components/address.component';
import { eventCheckoutPage } from '../../pages/portal/event-checkout.page';
import { receiptPage } from '../../pages/portal/receipt.page';
import { contactPage } from '../../pages/salesforce/contact.page';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string | string[] } = {};

After({ tags: '@TEST_PD-29241' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await localSharedData.salesorderId) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);

  const attendee = (
    await conn.query<Fields$EventApi__Attendee__c>(
      `Select Id, EventApi__Registration_Group__c from EventApi__Attendee__c where EventApi__Attendee_Event__c ='${await browser.sharedStore.get(
        'eventId',
      )}' and EventApi__Contact__r.Name = '${await localSharedData.contactName}'`,
    )
  ).records[0];

  const deleteAttendee = await conn.destroy('EventApi__Attendee__c', attendee.Id as string);
  expect(deleteAttendee.success).toEqual(true);

  const deleteEventRegGroup = await conn.destroy(
    'EventApi__Registration_Group__c',
    attendee.EventApi__Registration_Group__c as string,
  );
  expect(deleteEventRegGroup.success).toEqual(true);
});

Then(
  'User {string} selects no session and completes the event payment process using saved payment',
  async (contact: string) => {
    localSharedData.contactName = contact;
    const savedPaymentCount = await conn.query<Fields$OrderApi__Payment_Method__c>(
      `Select Id from OrderApi__Payment_Method__c where OrderApi__Contact__r.Name = '${contact}'`,
    );
    if (savedPaymentCount.records.length < 1) await contactPage.addNewPaymentMethod(contact, 'visa', '1111');
    await agendaPage.click(await agendaPage.continue);
    await addressComponent.click(await addressComponent.buttonContinue);
    await eventCheckoutPage.click(await eventCheckoutPage.savedPayment);
    expect(await eventCheckoutPage.getText(await eventCheckoutPage.savedPaymentList)).not.toBe('');
    await eventCheckoutPage.click(await eventCheckoutPage.processPayment);
    await receiptPage.waitForPresence(await receiptPage.eventConfirmationMessage);
    localSharedData.receiptId = (await receiptPage.getText(await receiptPage.eventReceiptId)).split('#');
    expect(await receiptPage.isDisplayed(await receiptPage.eventConfirmationMessage)).toBe(true);
  },
);

Then('User verifies that the system created only one receipt', async () => {
  localSharedData.salesorderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(`Select OrderApi__Sales_Order__c from OrderApi__Receipt__c 
    WHERE Name = '${localSharedData.receiptId[1]}'`)
  ).records[0].OrderApi__Sales_Order__c as string;

  const receiptCount = (
    await conn.query<Fields$OrderApi__Receipt__c>(`Select Id from OrderApi__Receipt__c 
    WHERE OrderApi__Sales_Order__c='${localSharedData.salesorderId}'`)
  ).records;
  expect(receiptCount.length).toEqual(1);
});
