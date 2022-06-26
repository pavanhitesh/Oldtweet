import { After, Before, DataTable, Given, Then, When } from '@cucumber/cucumber';
import { receiptPage } from '../../pages/portal/receipt.page';
import { accountPage } from '../../pages/salesforce/account.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { createInvoicePage } from '../../pages/salesforce/create-Invoice.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$Account, Fields$Contact, Fields$OrderApi__Receipt__c } from '../../fonteva-schema';
import { commonPortalPage } from '../../pages/portal/common.page';
import { companyOrdersPage } from '../../pages/portal/company-orders.page';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import * as data from '../data/common-data.json';
import { checkoutPage } from '../../pages/portal/checkout.page';

const accountDetails: string[] = [];
const localSharedData: { [key: string]: string[] } = {};

Before({ tags: '@TEST_PD-27049' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27049' }, async () => {
  const deleteSOResponse = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.soIds);
  deleteSOResponse.forEach((response) => {
    expect(response.success).toEqual(true);
  });
});

Given(`All salesOrders and receipts from account {string} are deleted`, async (accountName: string) => {
  await accountPage.deleteSalesOrder(accountName);
  await accountPage.deleteReceipts(accountName);
});

When(`User creates salesOrders from account using ROE from contacts as below:`, async (details: DataTable) => {
  const salesOrderIds: string[] = [];
  const orderData = details.hashes();
  await orderData.reduce(async (memo, soData) => {
    await memo;
    const accountId = (await conn.query<Fields$Account>(`SELECT Id FROM Account WHERE Name='${soData.Account}'`))
      .records[0].Id;
    accountDetails.push(accountId);
    await accountPage.openAccountPage(accountId);
    await accountPage.openRapidOrderEntryPage();
    expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.itemQuickAddTextBox)).toBe(true);
    await rapidOrderEntryPage.changeContactForOrder(soData.Contacts);
    expect(await rapidOrderEntryPage.getSelectedContactForOrder()).toContain(soData.Contacts);
    await rapidOrderEntryPage.addItemToOrder(soData.ItemName);
    expect(await rapidOrderEntryPage.verifyItemAddedToOrder(soData.ItemName)).toBe(true);
    await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther(soData.PaymentType);
    await createInvoicePage.click(await createInvoicePage.readyForPaymentButton);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
    salesOrderIds.push(
      await (await (await salesOrderPage.getUrl()).split('/OrderApi__Sales_Order__c/')[1]).split('/')[0],
    );
  }, undefined);
  localSharedData.soIds = salesOrderIds;
});

When(`User opens Company Order Page and select the orders created to pay`, async () => {
  await commonPortalPage.openCompanyOrders();
  await companyOrdersPage.selectAllOrders();
  await companyOrdersPage.clickPay();
});

When(`User successfully pays for the account orders with credit card`, async () => {
  await checkoutPage.waitForPresence(await checkoutPage.companyOrderInvoicePaymentContinue);
  await checkoutPage.click(await checkoutPage.companyOrderInvoicePaymentContinue);
  await creditCardComponent.waitForPresence(await creditCardComponent.linkCreditCard);
  await creditCardComponent.addNewCreditCardDetails(
    data.creditCardNumber,
    data.creditCardCVV,
    data.creditCardExpMonth,
    data.creditCardExpYear,
  );
  await creditCardComponent.click(await creditCardComponent.buttonProcessPayment);
  expect(await receiptPage.paymentConfirmationMessage).toBeDisplayed();
});

Then(`User verifies the payee name in Receipt is primary contact {string}`, async (payeeName: string) => {
  const { Id } = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT Id FROM OrderApi__Receipt__c WHERE OrderApi__Account__c = '${accountDetails[0]}'`,
    )
  ).records[0];

  const { Name } = (
    await conn.query<Fields$Contact>(
      `SELECT Name From CONTACT Where Id in (SELECT orderApi__contact__c FROM OrderApi__Receipt__c WHERE Id = '${Id}')`,
    )
  ).records[0];

  expect(Name).toEqual(payeeName);
});
