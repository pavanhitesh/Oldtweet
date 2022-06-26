import { Before, Then, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Renewal__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { subscriptionPage } from '../../pages/portal/subscription.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28795' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28795' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then('User updates the post term renewal window as {string} in the subscription plan', async (count: number) => {
  const termDetails = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription_Plan__c, OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  localSharedData.subscriptionId = termDetails.OrderApi__Subscription__c as string;
  localSharedData.subscriptionPlan = termDetails.OrderApi__Subscription_Plan__c as string;

  const postTermRenewalWindow = await conn.tooling
    .executeAnonymous(`OrderApi__Subscription_Plan__c renewalWindow = [Select Id from OrderApi__Subscription_Plan__c Where Id = '${localSharedData.subscriptionPlan}'];
    renewalWindow.OrderApi__PostTerm_Renewal_Window__c = ${count};
    update renewalWindow;`);
  expect(postTermRenewalWindow.success).toEqual(true);
});

Then('User verifies the renew button is {string}', async (action: string) => {
  await subscriptionPage.refreshBrowser();
  await subscriptionPage.click(await subscriptionPage.viewInactiveSubscriptions);
  if (action === 'displayed')
    expect(await subscriptionPage.isDisplayed(await subscriptionPage.expiredSubRenew)).toBe(true);
  else expect(await subscriptionPage.isDisplayed(await subscriptionPage.expiredSubRenew)).toBe(false);
});
