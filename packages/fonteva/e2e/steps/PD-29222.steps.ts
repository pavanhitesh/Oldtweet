import { After, Before, Then } from '@cucumber/cucumber';
import {
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { subscriptionPage } from '../../pages/salesforce/subscription.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29508' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should update the term end date to the past date and renews the subscription', async () => {
  const salesOrderIds: string[] = [];
  await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
  const termEndDate = await subscriptionPage.getDate('MM/dd/yyyy', 0, -2);
  localSharedData.salesOrderId = await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0];
  localSharedData.salesOrderLineId = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
    )
  ).records[0].Id;
  localSharedData.subscriptionId = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT Id FROM OrderApi__Subscription__c WHERE OrderApi__Sales_Order_Line__c = '${localSharedData.salesOrderLineId}'`,
    )
  ).records[0].Id;
  const termUpdateResponse = await conn.tooling
    .executeAnonymous(`OrderApi__Renewal__c status = [Select Id from OrderApi__Renewal__c Where OrderApi__Subscription__c = '${localSharedData.subscriptionId}' AND OrderApi__Is_Active__c = true];
  status.OrderApi__Term_End_Date__c = date.parse('${termEndDate}');
  update status;`);
  expect(termUpdateResponse.success).toEqual(true);
  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${localSharedData.subscriptionId}/view`);
  await subscriptionPage.waitForPresence(await subscriptionPage.header);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  localSharedData.salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name ='${await salesOrderPage.getText(
        await salesOrderPage.salesOrderNumber,
      )}'`,
    )
  ).records[0].Id;
  salesOrderIds.push(await localSharedData.salesOrderId);
  await browser.sharedStore.set('salesOrderIds', salesOrderIds);
});

Then(`User updates the latest term end date to the past date and renews the subscription again`, async () => {
  const salesOrderIds: string[] = [];
  const termEndDate = await subscriptionPage.getDate('MM/dd/yyyy', 0, -2);
  await subscriptionPage.sleep(MilliSeconds.XXS); // for data creation
  const termUpdateResponse = await conn.tooling
    .executeAnonymous(`OrderApi__Renewal__c termRecord = [Select Id from OrderApi__Renewal__c Where OrderApi__Subscription__c = '${localSharedData.subscriptionId}' AND OrderApi__Is_Active__c = true];
  termRecord.OrderApi__Term_End_Date__c = date.parse('${termEndDate}');
  update termRecord;`);
  expect(termUpdateResponse.success).toEqual(true);
  await subscriptionPage.open(`/lightning/r/OrderApi__Subscription__c/${localSharedData.subscriptionId}/view`);
  await subscriptionPage.waitForPresence(await subscriptionPage.header);
  await subscriptionPage.click(await subscriptionPage.renew);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  localSharedData.salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name ='${await salesOrderPage.getText(
        await salesOrderPage.salesOrderNumber,
      )}'`,
    )
  ).records[0].Id;
  salesOrderIds.push(await localSharedData.salesOrderId);
  await browser.sharedStore.set('salesOrderIds', salesOrderIds);
});

Then('User should be able to verify previous term date is present for new term date', async () => {
  await subscriptionPage.sleep(MilliSeconds.XXS);
  const termStatus = await (
    await conn.query(
      `SELECT Id, OrderApi__Previous_Term__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${localSharedData.subscriptionId}'`,
    )
  ).records;
  expect(termStatus[2].OrderApi__Previous_Term__c).toEqual(termStatus[1].Id);
  expect(termStatus[1].OrderApi__Previous_Term__c).toEqual(termStatus[0].Id);
  expect(termStatus[0].OrderApi__Previous_Term__c).toEqual(null);
});

After({ tags: '@TEST_PD-29508' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
