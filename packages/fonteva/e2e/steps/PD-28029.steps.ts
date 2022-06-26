import { After, Before, Then, When } from '@cucumber/cucumber';
import * as faker from 'faker';
import {
  Fields$Contact,
  Fields$OrderApi__Receipt_Line__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28342' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28342' }, async () => {
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrder as string);
  expect(deleteSO.success).toEqual(true);
});

When(`User changes the order contact to non-primary contact of the selected account`, async () => {
  const { Name } = (
    await conn.query<Fields$Contact>(
      `SELECT Name FROM Contact WHERE OrderApi__Is_Primary_Contact__c = false AND AccountId = '${await browser.sharedStore.get(
        'accountId',
      )}'`,
    )
  ).records[0];
  await rapidOrderEntryPage.changeContactForOrder(Name);
  expect(await rapidOrderEntryPage.getSelectedContactForOrder()).toContain(Name);
  localSharedData.contactName = Name;
});

When(`User Selects the {string} as payment mode and applies payment`, async (paymentMode: string) => {
  await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentMode);
  await applyPaymentPage.typeReferenceNumber(faker.datatype.uuid());
  await applyPaymentPage.clickApplyPayments();
  expect(await receiptPage.isDisplayed(await receiptPage.receiptNumber)).toBe(true);
  browser.sharedStore.set('receiptNameROE', await receiptPage.receiptNumber.getText());
});

Then(
  `User verifies that the selected contact is associated to created SalesOrder, SalesOrderLines, Receipt and Receipt Lines`,
  async () => {
    const contactId = (
      await conn.query<Fields$Contact>(`SELECT Id FROM Contact WHERE Name = '${localSharedData.contactName}'`)
    ).records[0].Id;

    const receiptData = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT Id, OrderApi__Contact__c, OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0];

    expect(receiptData.OrderApi__Contact__c).toEqual(contactId);
    localSharedData.salesOrder = receiptData.OrderApi__Sales_Order__c as string;

    const soContactId = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Contact__c FROM OrderApi__Sales_Order__c WHERE Id = '${receiptData.OrderApi__Sales_Order__c}'`,
      )
    ).records[0].OrderApi__Contact__c;

    expect(soContactId).toEqual(contactId);

    const receiptLinesData = (
      await conn.query<Fields$OrderApi__Receipt_Line__c>(
        `SELECT OrderApi__Contact__c FROM OrderApi__Receipt_Line__c WHERE OrderApi__Receipt__c = '${receiptData.Id}'`,
      )
    ).records;

    await receiptLinesData.forEach(async (receiptLineRecord) => {
      await expect(receiptLineRecord.OrderApi__Contact__c).toEqual(contactId);
    });

    const salesOrderLinesData = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Contact__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrder}'`,
      )
    ).records;

    await salesOrderLinesData.forEach(async (salesOrderLineRecord) => {
      await expect(salesOrderLineRecord.OrderApi__Contact__c).toEqual(contactId);
    });
  },
);
