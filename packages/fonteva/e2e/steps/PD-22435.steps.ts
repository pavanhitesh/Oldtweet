import { After, Before, Then, When } from '@cucumber/cucumber';
import {
  Fields$OrderApi__EPayment__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import { portalLoginPage } from '../../pages/portal/login.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';

let salesOrderId = '';

Before({ tags: '@TEST_PD-27626' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27626' }, async () => {
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

When('User sends email with payment link and opens the payment link', async () => {
  const paymentLink = await proformaInvoicePage.getPaymentLinkFromEmail();
  const tempsalesOrderId = paymentLink.split('/checkout/')[1];
  salesOrderId = tempsalesOrderId;
  await proformaInvoicePage.click(await proformaInvoicePage.sendEmail);
  await proformaInvoicePage.waitForPresence(await proformaInvoicePage.emailSentSuccessMessage);
  expect(await proformaInvoicePage.getText(await proformaInvoicePage.emailSentSuccessMessage)).toContain(
    'Your Email Has Been Sent.',
  );
  await proformaInvoicePage.openNewWindow(paymentLink);
  await proformaInvoicePage.waitForAjaxCall();
});

When(
  `User logins to the portal from payment page with username {string} and password {string}`,
  async (username, password) => {
    await portalLoginPage.click(await portalLoginPage.alreadyMemberLoginBtn);
    await portalLoginPage.portalLogin(username, password);
    await creditCardComponent.waitForPresence(await creditCardComponent.linkCreditCard);
    expect(await creditCardComponent.isDisplayed(await creditCardComponent.linkCreditCard)).toBe(true);
  },
);

Then(
  `User goes to salesforce and verify the SalesOrder, Receipt and Transaction records entity value is populated as Account`,
  async () => {
    const soEntity = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Entity__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrderId}'`,
      )
    ).records[0].OrderApi__Entity__c;

    expect(soEntity).toEqual('Account');

    const receiptEntity = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Entity__c FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'`,
      )
    ).records[0].OrderApi__Entity__c;

    expect(receiptEntity).toEqual('Account');

    const trxnEntity = (
      await conn.query<Fields$OrderApi__EPayment__c>(
        `SELECT OrderApi__Entity__c FROM OrderApi__EPayment__c WHERE OrderApi__Sales_Order__c  = '${salesOrderId}'`,
      )
    ).records[0].OrderApi__Entity__c;

    expect(trxnEntity).toEqual('Account');
  },
);
