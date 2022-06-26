import { After, Before, DataTable, Then, When } from '@cucumber/cucumber';
import {
  Fields$Account,
  Fields$LTE__Site__c,
  Fields$OrderApi__Receipt_Line__c,
  Fields$OrderApi__Receipt__c,
} from '../../fonteva-schema';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { conn } from '../../shared/helpers/force.helper';
import { accountPage } from '../../pages/salesforce/account.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import * as data from '../data/common-data.json';
import { receiptPage } from '../../pages/portal/receipt.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedDataProformaSO: string[] = [];

Before({ tags: '@TEST_PD-28541' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28541' }, async () => {
  const deleteSOResponse = await conn.destroy('OrderApi__Sales_Order__c', localSharedDataProformaSO);
  deleteSOResponse.forEach((response) => {
    expect(response.success).toEqual(true);
  });
});

When(`User creates salesOrders using ROE from account with below information:`, async (orderDetails: DataTable) => {
  const orderData = orderDetails.hashes();
  await orderData.reduce(async (memo, soData) => {
    await memo;
    const accountId = await (
      await conn.query<Fields$Account>(`SELECT Id FROM Account WHERE Name='${soData.Account}'`)
    ).records[0].Id;
    await accountPage.openAccountPage(accountId);
    await accountPage.openRapidOrderEntryPage();
    expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.itemQuickAddTextBox)).toBe(true);
    await rapidOrderEntryPage.addItemToOrder(soData.ItemName);
    expect(await rapidOrderEntryPage.verifyItemAddedToOrder(soData.ItemName)).toBe(true);
    await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther(soData.PaymentType);
    await proformaInvoicePage.waitForPresence(await proformaInvoicePage.proformaInvoicePageHeader);
    expect(await proformaInvoicePage.isDisplayed(await proformaInvoicePage.proformaInvoicePageHeader)).toBe(true);
    const soId = await (await proformaInvoicePage.getPaymentLinkFromEmail()).split('/checkout/')[1];
    localSharedDataProformaSO.push(soId);
    await proformaInvoicePage.click(await proformaInvoicePage.sendEmail);
    await proformaInvoicePage.waitForPresence(await proformaInvoicePage.emailSentSuccessMessage);
    expect(await proformaInvoicePage.getText(await proformaInvoicePage.emailSentSuccessMessage)).toContain(
      'Your Email Has Been Sent.',
    );
  }, undefined);
});

When(`User opens the checkout page for the orders created`, async () => {
  const portalURL = (
    await conn.query<Fields$LTE__Site__c>(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`)
  ).records[0].LTE__Site_URL__c as string;

  const checkoutURL =
    `${portalURL}/#/store/checkout/${localSharedDataProformaSO[0]},${localSharedDataProformaSO[1]}` as string;
  await checkoutPage.open(checkoutURL);
  await checkoutPage.waitForPresence(await creditCardComponent.buttonProcessPayment);

  expect(await creditCardComponent.isDisplayed(await creditCardComponent.buttonProcessPayment)).toBe(true);
});

When(`User successfully pays for the orders using credit card`, async () => {
  await creditCardComponent.addNewCreditCardDetails(
    data.creditCardNumber,
    data.creditCardCVV,
    data.creditCardExpMonth,
    data.creditCardExpYear,
  );
  await creditCardComponent.click(await creditCardComponent.buttonProcessPayment);
  expect(await receiptPage.paymentConfirmationMessage).toBeDisplayed();
});

Then(`User verifies the Receipt and ePayment record is created for the paid orders`, async () => {
  await receiptPage.sleep(MilliSeconds.XXS); // Wait needed for the data to be created in backend

  const receiptId = (
    await conn.query<Fields$OrderApi__Receipt_Line__c>(
      `SELECT OrderApi__Receipt__c FROM OrderApi__Receipt_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedDataProformaSO[0]}'`,
    )
  ).records[0].OrderApi__Receipt__c;

  expect(receiptId).not.toBe('');

  // Verifying Epayment Record is created using the receipt ID
  const epaymentRecords = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__EPayment__c FROM OrderApi__Receipt__c WHERE Id = '${receiptId}'`,
    )
  ).records;

  expect(epaymentRecords.length).toBe(1);
  expect(epaymentRecords[0].OrderApi__EPayment__c).not.toBe('');

  // Verifying SO's are linked to the Receipt Lines using Receipt Id
  const receiptLines = (
    await conn.query<Fields$OrderApi__Receipt_Line__c>(
      `SELECT Id, OrderApi__Sales_Order__c FROM OrderApi__Receipt_Line__c WHERE OrderApi__Receipt__c = '${receiptId}' ORDER BY Id DESC`,
    )
  ).records;

  expect(receiptLines.length).toBe(2);
  expect(localSharedDataProformaSO).toContainEqual(receiptLines[0].OrderApi__Sales_Order__c);
  expect(localSharedDataProformaSO).toContainEqual(receiptLines[1].OrderApi__Sales_Order__c);
});
