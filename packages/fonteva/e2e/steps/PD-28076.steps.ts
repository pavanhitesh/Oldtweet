/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Given, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$Contact } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28762' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28762' }, async () => {
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);

  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
});

Given('User creates New Sales Order with contact as {string} & opens the sales order', async (contactName: string) => {
  const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${contactName}'`))
    .records[0].Id;
  const soResponse: any = await conn.create('OrderApi__Sales_Order__c', [
    {
      OrderApi__Entity__c: 'Contact',
      OrderApi__Contact__c: contactId,
      OrderApi__Posting_Entity__c: 'Receipt',
      OrderApi__Schedule_Type__c: 'Simple Receipt',
    },
  ]);
  expect(soResponse[0].success).toEqual(true);
  localSharedData.salesOrderId = soResponse[0].id as string;
  await salesOrderPage.open(`/lightning/r/OrderApi__Sales_Order__c/${localSharedData.salesOrderId}/view`);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
});

Then(`User verifies the enity type value in Sales order line and Subscription is contact`, async () => {
  const subscriptionData = (
    await conn.query(
      `SELECT Id, OrderApi__Entity__c, OrderApi__Sales_Order_Line__r.OrderApi__Entity__c FROM OrderApi__Subscription__c where OrderApi__Sales_Order_Line__c IN (SELECT ID FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Id = '${localSharedData.salesOrderId}')`,
    )
  ).records[0];
  localSharedData.subscriptionId = subscriptionData.Id as string;
  expect(subscriptionData.OrderApi__Entity__c).toEqual('Contact');
  expect(subscriptionData.OrderApi__Sales_Order_Line__r.OrderApi__Entity__c).toEqual('Contact');
});
