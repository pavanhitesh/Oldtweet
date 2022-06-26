import { Before, Given, After, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import {
  Fields$Contact,
  Fields$OrderApi__Receipt_Line__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28727' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28727' }, async () => {
  const deleteSalesOrder = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId as string);
  expect(deleteSalesOrder.success).toEqual(true);
});

Given('User changes the order contact to non-primary contact {string}', async (contactName: string) => {
  await rapidOrderEntryPage.changeContactForOrder(contactName);
  expect(await rapidOrderEntryPage.getText(await rapidOrderEntryPage.contactSelected)).toEqual(contactName);
  localSharedData.contactId = (
    await conn.query<Fields$Contact>(`SELECT Id from Contact WHERE Name = '${contactName}'`)
  ).records[0].Id;
});

Then(
  'User verfies the non-primary contact is displayed in receipt,receipt line item,salesorder and salesorder line item',
  async () => {
    const receiptResponse = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Contact__c,OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0];
    expect(receiptResponse.OrderApi__Contact__c).toEqual(localSharedData.contactId);
    localSharedData.salesOrderId = receiptResponse.OrderApi__Sales_Order__c as string;
    const receiptLineItemContact = (
      await conn.query<Fields$OrderApi__Receipt_Line__c>(
        `SELECT OrderApi__Contact__c FROM OrderApi__Receipt_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
      )
    ).records[0].OrderApi__Contact__c;
    expect(receiptLineItemContact).toEqual(localSharedData.contactId);

    const salesOrderContact = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Contact__c FROM OrderApi__Sales_Order__c WHERE Id = '${localSharedData.salesOrderId}'`,
      )
    ).records[0].OrderApi__Contact__c;
    expect(salesOrderContact).toEqual(localSharedData.contactId);

    const salesOrderLineContact = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Contact__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
      )
    ).records[0].OrderApi__Contact__c;
    expect(salesOrderLineContact).toEqual(localSharedData.contactId);
  },
);
