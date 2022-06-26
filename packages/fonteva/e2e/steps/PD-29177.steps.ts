import { After, When } from '@cucumber/cucumber';
import { manageSubscriptionPage } from '../../pages/portal/manage-subscription.page';
import { Fields$OrderApi__Renewal__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { contactPage } from '../../pages/salesforce/contact.page';

const localSharedData: { [key: string]: string } = {};

After({ tags: '@TEST_PD-29641' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId);
  expect(salesOrderDeleted.success).toEqual(true);
});

When(`User enables auto Renew and updates payment method for the subscription created`, async () => {
  localSharedData.salesOrderId = await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0];

  localSharedData.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c;
  const subscriptionAutoRenewUpdateResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Subscription__c subsRecord = [Select OrderApi__Enable_Auto_Renew__c, OrderApi__Payment_Method__c from OrderApi__Subscription__c Where Id = '${
    localSharedData.subscriptionId
  }'];
  subsRecord.OrderApi__Enable_Auto_Renew__c = true;
  subsRecord.OrderApi__Payment_Method__c = '${await browser.sharedStore.get('paymentMethodId')}';
  update subsRecord;`);
  expect(subscriptionAutoRenewUpdateResponse.success).toEqual(true);
});

When(
  `User verifies the payment method displayed on portal is of card type {string} and last four digits are {string}`,
  async (cardType: string, lastfourDigits: string) => {
    await manageSubscriptionPage.refreshBrowser();
    await manageSubscriptionPage.waitForPresence(await manageSubscriptionPage.paymentMethodValue);
    const actualPaymentMethod = await manageSubscriptionPage.getText(await manageSubscriptionPage.paymentMethodValue);
    const expectedPaymentMethod = `${cardType} ending in ${lastfourDigits}`;
    expect(actualPaymentMethod.toLowerCase()).toEqual(expectedPaymentMethod.toLowerCase());
  },
);

When(
  `User updates subscription with new payment method of contact {string} with cardtype {string} and last four digits {string}`,
  async (contactName: string, cardType: string, lastFourDigits: string) => {
    await contactPage.deletePaymentMethod(contactName);
    const paymethodResponse = await contactPage.addNewPaymentMethod(contactName, cardType, lastFourDigits);
    expect(paymethodResponse.success).toEqual(true);

    const subscriptionPayMethodUpdateResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Subscription__c subsRecord = [Select OrderApi__Payment_Method__c from OrderApi__Subscription__c Where Id = '${localSharedData.subscriptionId}'];
  subsRecord.OrderApi__Payment_Method__c = '${paymethodResponse.id}';
  update subsRecord;`);
    expect(subscriptionPayMethodUpdateResponse.success).toEqual(true);
  },
);
