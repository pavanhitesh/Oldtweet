import { After, Before, Then, When } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { contactPage } from '../../pages/salesforce/contact.page';
import * as data from '../data/PD-28010.json';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Item__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { commonPage } from '../../pages/salesforce/_common.page';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@TEST_PD-28781' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
  await contactPage.deleteCreditMemo(data.ContactName);
});

After({ tags: '@TEST_PD-28781' }, async () => {
  await contactPage.deleteCreditMemo(data.ContactName);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});

When(
  `User opens the SalesOrder created and navigates to apply payment page and verifies available credit is {string}`,
  async (creditMemoAmount: string) => {
    await salesOrderPage.sleep(MilliSeconds.S); // Added to wait for credit memo posting to complete
    localSharedData.salesOrderId = (await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0]) as string;
    await salesOrderPage.open(`/lightning/r/OrderApi__Sales_Order__c/${localSharedData.salesOrderId}/view`);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);

    await salesOrderPage.click(await salesOrderPage.applyPayment);
    const applyPaymentPageFrame = await (
      await $('div[class="oneAlohaPage"]')
    ).shadow$('iframe[title="accessibility title"]');
    await applyPaymentPage.waitForPresence(applyPaymentPageFrame);
    await applyPaymentPage.switchToFrame(applyPaymentPageFrame);
    await applyPaymentPage.waitForPresence(await applyPaymentPage.applyPayment);

    expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment)).toEqual(true);
    expect(await applyPaymentPage.getText(await applyPaymentPage.availableCredit)).toEqual(`$${creditMemoAmount}.00`);
  },
);

When(`User makes payment for {string} using credits`, async (itemName: string) => {
  localSharedData.itemPrice = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE Name = '${itemName}'`,
    )
  ).records[0].OrderApi__Price__c as number;

  await applyPaymentPage.type(await applyPaymentPage.creditAppliedAmountInput, localSharedData.itemPrice);
  await applyPaymentPage.sleep(MilliSeconds.XXS);
  await applyPaymentPage.clearInput(await applyPaymentPage.paymentAmountInput);
  await applyPaymentPage.type(await applyPaymentPage.paymentAmountInput, 0);
  await applyPaymentPage.sleep(MilliSeconds.XXS);

  expect(await applyPaymentPage.getText(await applyPaymentPage.balanceDueAmount)).toEqual(
    `$${localSharedData.itemPrice}.00`,
  );
  expect(await applyPaymentPage.getText(await applyPaymentPage.creditAppliedAmount)).toEqual(
    `$${localSharedData.itemPrice}.00`,
  );

  await applyPaymentPage.click(await applyPaymentPage.applyPayment);

  if (await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment))
    await applyPaymentPage.click(await applyPaymentPage.applyPayment);

  // used commonPage and generic header locator as 21Winter and 22Winter are redirected to different pages.
  await commonPage.waitForPresence(await commonPage.pageHeader);
  expect(await commonPage.isDisplayed(await commonPage.pageHeader)).toBe(true);
});

Then(`User verifies the credits applied and Balance due values`, async () => {
  const salesOrderData = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Balance_Due__c, OrderApi__Credits_Applied__c FROM OrderApi__Sales_Order__c WHERE Id = '${localSharedData.salesOrderId}'`,
    )
  ).records[0];

  expect(salesOrderData.OrderApi__Balance_Due__c).toEqual(0);
  expect(salesOrderData.OrderApi__Credits_Applied__c).toEqual(localSharedData.itemPrice);
});
