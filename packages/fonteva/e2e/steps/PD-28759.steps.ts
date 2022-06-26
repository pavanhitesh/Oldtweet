import { After, Then, When } from '@cucumber/cucumber';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import {
  Fields$LTE__Site__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { portalLoginPage } from '../../pages/portal/login.page';

After({ tags: '@TEST_PD-28893' }, async () => {
  await commonPortalPage.logoutPortal();
  expect(await portalLoginPage.isDisplayed(await portalLoginPage.username)).toBe(true);

  const deleteSOResponse = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('portalSO')) as string,
  );
  expect(deleteSOResponse.success).toEqual(true);
});

After({ tags: '@TEST_PD-29206' }, async () => {
  const deleteSOResponse = await conn.destroy(
    'OrderApi__Sales_Order__c',
    await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0],
  );
  expect(deleteSOResponse.success).toEqual(true);
});

Then(
  `user verifies the billing contact is populated as {string} on SalesOrder and receipt created by {string}`,
  async (contactName: string, userType: string) => {
    let salesOrderId;

    if (userType === 'same user') salesOrderId = (await browser.sharedStore.get('portalSO')) as string;
    else salesOrderId = await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0];

    const soData = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Billing_Contact__c, OrderApi__Calculate_Billing_Details__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrderId}'`,
      )
    ).records[0];

    expect(soData.OrderApi__Calculate_Billing_Details__c).toBe(true);
    expect(soData.OrderApi__Billing_Contact__c).toBe(contactName);

    const receiptData = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Billing_Contact__c, OrderApi__Calculate_Billing_Details__c FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'`,
      )
    ).records[0];

    expect(receiptData.OrderApi__Calculate_Billing_Details__c).toBe(true);
    expect(receiptData.OrderApi__Billing_Contact__c).toBe(contactName);
  },
);

When(`User opens checkout page for the order created and continue to payment Section`, async () => {
  const portalURL = (
    await conn.query<Fields$LTE__Site__c>(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`)
  ).records[0].LTE__Site_URL__c as string;

  await checkoutPage.open(
    `${portalURL}/#/store/checkout/${((await browser.sharedStore.get('salesOrderIds')) as string[])[0]}` as string,
  );

  await checkoutPage.waitForAjaxCall();
  await checkoutPage.click(await checkoutPage.companyOrderInvoicePaymentContinue);
  await creditCardComponent.waitForPresence(await creditCardComponent.linkCreditCard);
  expect(await creditCardComponent.isDisplayed(await creditCardComponent.linkCreditCard)).toBe(true);
});
