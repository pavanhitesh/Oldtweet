import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Receipt__c, Fields$OrderApi__Renewal__c } from '../../fonteva-schema';
import { receiptPage } from '../../pages/portal/receipt.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import * as data from '../data/PD-13256.json';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-27191' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should be able to remove sales order line source from the subscription', async () => {
  await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
  state.salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}'`,
    )
  ).records[0].OrderApi__Sales_Order__c as string;
  state.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  const response = await conn.tooling.executeAnonymous(`
  OrderApi__Subscription__c Subscription = [Select OrderApi__Sales_Order_Line__c from OrderApi__Subscription__c Where Id = '${state.subscriptionId}'];
  Subscription.OrderApi__Sales_Order_Line__c = null ;
  update Subscription;`);
  expect(response.success).toEqual(true);
});

Then(
  'User should be able to renew the {string} subscription {string}',
  async (status: string, subscription: string) => {
    if (status === 'expired') {
      await subscriptionPage.click(await subscriptionPage.viewInactiveSubscriptions);
      await subscriptionPage.click(await subscriptionPage.expiredSubRenew);
    } else {
      await subscriptionPage.click(await subscriptionPage.renew);
    }
    await subscriptionPage.click(
      await $(`//div[text() = '${subscription}'] /parent::div /parent::div /parent::div //button`),
    );
    await subscriptionPage.click(await assignMemberPage.AddToCart);
    await shoppingCartPage.click(await shoppingCartPage.cartCheckout);
    const salesOrderinCookie = JSON.parse(
      (
        await browser.getCookies([
          `apex__${await browser.sharedStore.get('organizationId')}-fonteva-community-shopping-cart`,
        ])
      )[0].value,
    ).salesOrderId;
    browser.sharedStore.set('portalSO', salesOrderinCookie);
    await creditCardComponent.addNewCreditCardDetails(
      data.creditCardNumber,
      data.creditCardCVV,
      data.creditCardExpMonth,
      data.creditCardExpYear,
    );
    await checkoutPage.waitForEnable(await creditCardComponent.buttonProcessPayment);
    await checkoutPage.click(await creditCardComponent.buttonProcessPayment);
    await receiptPage.waitForPresence(await receiptPage.invoiceConfirmationMessage);
    expect(await receiptPage.isDisplayed(await receiptPage.invoiceConfirmationMessage)).toEqual(true);
  },
);

After({ tags: '@TEST_PD-27191' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
