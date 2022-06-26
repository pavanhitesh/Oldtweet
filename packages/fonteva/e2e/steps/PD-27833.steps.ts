import { After, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Transaction_Line__c, Fields$OrderApi__Transaction__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

After({ tags: '@TEST_PD-29216' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy((await browser.sharedStore.get('subscriptionId')) as string);
  expect(deleteSubscription.success).toEqual(true);

  const deleteRenewalSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteRenewalSO.success).toEqual(true);

  const deleteOriginalSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('SalesOrderId')) as string);
  expect(deleteOriginalSO.success).toEqual(true);
});

Then(`User verifies generated receipt has the Transaction and Transaction lines created`, async () => {
  const transactionData = (
    await conn.query<Fields$OrderApi__Transaction__c>(
      `SELECT Id FROM OrderApi__Transaction__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
        'portalSO',
      )}' AND OrderApi__Type__c = 'Cash'`,
    )
  ).records;

  expect(transactionData.length).toBe(1);

  const transactionLineData = (
    await conn.query<Fields$OrderApi__Transaction_Line__c>(
      `SELECT Id FROM OrderApi__Transaction_Line__c WHERE OrderApi__Transaction__c = '${transactionData[0].Id}'`,
    )
  ).records;

  expect(transactionLineData.length).toBe(4);
});
