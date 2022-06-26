import { After, Before, DataTable, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import * as commondata from '../data/common-data.json';
import * as data from '../data/PD-27973.json';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$Contact,
  Fields$OrderApi__Known_Address__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { receiptPage } from '../../pages/salesforce/receipt.page';

Before({ tags: '@TEST_PD-28427' }, async () => {
  await loginPage.open('/');
  await loginPage.login();

  const contactId = (
    await conn.query<Fields$Contact>(
      `SELECT Id FROM Contact WHERE OrderApi__Is_Primary_Contact__c = true AND AccountId IN (SELECT Id FROM Account WHERE Name = '${data.AccountName}')`,
    )
  ).records[0].Id;

  const deleteKnownAddress = (
    await conn.query<Fields$OrderApi__Known_Address__c>(
      `SELECT Id FROM OrderApi__Known_Address__c WHERE OrderApi__Contact__c = '${contactId}'`,
    )
  ).records;
  const knownAddressIdList = deleteKnownAddress.map((item) => item.Id);
  await conn.destroy('OrderApi__Known_Address__c', knownAddressIdList);
});

After({ tags: '@TEST_PD-28427' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(salesOrderDeleted.success).toEqual(true);
});

Then(
  `User applies payment using {string} as payment type by entering below Billing Address details:`,
  async (paymentType: string, addressData: DataTable) => {
    const addressDetails = addressData.hashes()[0];
    await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentType);
    await (await applyPaymentPage.applyPayment).click();
    expect(await (await applyPaymentPage.processPayment).isDisplayed()).toBe(true);
    const cardName = faker.name.firstName();
    await applyPaymentPage.creditCardPayment(
      cardName,
      commondata.creditCardNumber,
      commondata.creditCardCVV,
      commondata.creditCardExpMonth,
      commondata.creditCardExpYear,
    );

    await applyPaymentPage.addNewAddress(
      addressDetails.Name,
      addressDetails.Type,
      addressDetails.Street,
      addressDetails.City,
      addressDetails.State,
      addressDetails.PostalCode,
    );

    await applyPaymentPage.click(await applyPaymentPage.processPayment);
    await applyPaymentPage.waitForPresence(await receiptPage.receiptNumber);
    expect(await (await receiptPage.receiptNumber).isDisplayed()).toBe(true);
  },
);
