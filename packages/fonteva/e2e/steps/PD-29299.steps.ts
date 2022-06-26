import { Before, Given } from '@cucumber/cucumber';
import { Fields$OrderApi__Renewal__c, Fields$OrderApi__Subscription__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-29504' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given('User renew the subscription and verifies the amount calculated for renewing the subscription', async () => {
  await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
  state.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${state.subscriptionId}/view`);
  await subscriptionPage.waitForPresence(await subscriptionPage.header);
  const termEndDate = await subscriptionPage.getDate('MM/dd/yyyy', 0, +1);
  const activatedDate = await conn.tooling
    .executeAnonymous(`OrderApi__Subscription__c activatedDate = [Select Id from OrderApi__Subscription__c Where Id = '${state.subscriptionId}'];
      activatedDate.OrderApi__Activated_Date__c = date.parse('${termEndDate}');
      update activatedDate;`);
  expect(activatedDate.success).toEqual(true);
  const response = await conn.tooling
    .executeAnonymous(`OrderApi__Renewal__c status = [Select Id from OrderApi__Renewal__c Where OrderApi__Subscription__c = '${state.subscriptionId}'];
      status.OrderApi__Term_End_Date__c = date.parse('${termEndDate}');
      update status;`);
  expect(response.success).toEqual(true);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  await salesOrderPage.click(await salesOrderPage.readyForPayment);
  await salesOrderPage.click(await salesOrderPage.applyPayment);
  await salesOrderPage.sleep(MilliSeconds.S);
  await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="accessibility title"]'));
  const subscriptionTotal = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `Select OrderApi__Subscription_Dues_Total__c from OrderApi__Subscription__c Where Id = '${state.subscriptionId}'`,
    )
  ).records[0].OrderApi__Subscription_Dues_Total__c as number;
  const monthlySubscription = subscriptionTotal / 12;
  const dateVal = new Date(Date.now());
  const currentMonth = dateVal.getMonth();
  const renewalAmount = monthlySubscription * (12 - currentMonth);

  expect(await applyPaymentPage.getText(await applyPaymentPage.paymentsApplied)).toContain(`$${renewalAmount}.00`);
  await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment)).toEqual(true);
});
