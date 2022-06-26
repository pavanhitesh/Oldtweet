import { Given, Before, Then, After } from '@cucumber/cucumber';
import { format } from 'date-fns';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Subscription__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Renewal__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-27639' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27639' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscription as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrder as string);
  expect(deleteSO.success).toEqual(true);
});

Given('User expires the subscription by updating date and verifies term status', async () => {
  const receipt = await receiptPage.getText(await receiptPage.receiptNumber);
  const salesOrder = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${receipt}'`,
    )
  ).records[0].OrderApi__Sales_Order__c;
  state.salesOrder = salesOrder as string;
  await receiptPage.sleep(MilliSeconds.XXS);
  const subscription = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT Id FROM OrderApi__Subscription__c WHERE OrderApi__Sales_Order_Line__c IN
      (SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrder}')`,
    )
  ).records[0].Id;
  state.subscription = subscription;
  await browser.sharedStore.set('subscription', subscription);
  const now = new Date();
  now.setDate(now.getDate() - 2);
  const termDate = format(now, 'MM/dd/yyyy');
  const activatedDate = await conn.tooling
    .executeAnonymous(`OrderApi__Subscription__c activatedDate = [Select Id from OrderApi__Subscription__c Where Id = '${subscription}'];
  activatedDate.OrderApi__Activated_Date__c = date.parse('${termDate}');
  update activatedDate;`);
  expect(activatedDate.success).toEqual(true);
  const response = await conn.tooling
    .executeAnonymous(`OrderApi__Renewal__c status = [Select Id from OrderApi__Renewal__c Where OrderApi__Subscription__c = '${subscription}'];
  status.OrderApi__Term_End_Date__c = date.parse('${termDate}');
  update status;`);
  expect(response.success).toEqual(true);
  const isActive = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Is_Active__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${subscription}'`,
    )
  ).records[0].OrderApi__Is_Active__c;
  expect(isActive).toEqual(false);
});

Then('User verifies the subscription renewal term is active for expired subscription', async () => {
  await receiptPage.sleep(MilliSeconds.XXS);
  const term = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Is_Active__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${state.subscription}'`,
    )
  ).records[1].OrderApi__Is_Active__c;
  expect(term).toEqual(true);
});
