import { Before, When, Then } from '@cucumber/cucumber';
import { format } from 'date-fns';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-27146' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

When('User selects Payment Mode as {string}', async (paymentMode: string) => {
  await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentMode);
});

When(
  'User select the Reference Number , Paid Date {string} and Posted Date {string} and complete the payment',
  async (paidDate: string, postDate: string) => {
    const dateString = new Date();
    await applyPaymentPage.typeReferenceNumber(dateString.toDateString());
    await applyPaymentPage.selectPaidAndPostDates(paidDate, postDate);
    await applyPaymentPage.clickApplyPayments();
    state.paidDate = format(new Date(paidDate), 'yyyy-MM-dd') as string;
    state.postDate = format(new Date(postDate), 'yyyy-MM-dd') as string;
  },
);

Then('User validate the Paid Date and Post Date in Receipt', async () => {
  const url = await browser.getUrl();
  const receiptId = url.split('/')[6];
  const { records } = await conn.query(
    `SELECT Id, OrderApi__Date__c, OrderApi__Payment_Type__c, OrderApi__Posted_Date__c, OrderApi__Reference_Number__c, OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Id = '${receiptId}'`,
  );
  state.salesOrderId = records[0].OrderApi__Sales_Order__c;
  expect(records[0].OrderApi__Date__c).toEqual(state.paidDate);
  expect(records[0].OrderApi__Posted_Date__c).toEqual(state.postDate);
});

Then('User validate the Paid Date and Post Date in SalesOrder', async () => {
  const { records } = await conn.query(
    `SELECT Name, OrderApi__Paid_Date__c, OrderApi__Posted_Date__c FROM OrderApi__Sales_Order__c WHERE Id = '${state.salesOrderId}'`,
  );
  expect(records[0].OrderApi__Paid_Date__c).toEqual(state.paidDate);
  expect(records[0].OrderApi__Posted_Date__c).toEqual(state.postDate);
});
