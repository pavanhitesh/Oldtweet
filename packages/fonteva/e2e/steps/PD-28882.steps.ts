import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__EPayment__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-28910' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28910' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);
});

Then(`User verifies the OrderId value in ePayment record`, async () => {
  const ePaymentOrderIdValue = (
    await conn.query<Fields$OrderApi__EPayment__c>(
      `SELECT OrderApi__Order_ID__c FROM OrderApi__EPayment__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Order_ID__c;

  expect(ePaymentOrderIdValue).toEqual(await browser.sharedStore.get('SalesOrderNumber'));
});
