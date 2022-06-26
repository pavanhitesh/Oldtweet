import { After, Before, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$OrderApi__Sales_Order_Line__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-28726' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28726' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});

Then(`User verifies the Overall Total, Amount Paid, Amount Refunded and Balance Due in sales order line`, async () => {
  const result = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT OrderApi__Overall_Total__c, OrderApi__Amount_Paid__c, OrderApi__Amount_Refunded__c, OrderApi__Balance_Due__c, OrderApi__Subtotal__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  expect(result.OrderApi__Overall_Total__c).toEqual(result.OrderApi__Subtotal__c);
  expect(result.OrderApi__Amount_Paid__c).toEqual(result.OrderApi__Subtotal__c);
  expect(result.OrderApi__Amount_Refunded__c).toEqual(result.OrderApi__Subtotal__c);
  expect(result.OrderApi__Balance_Due__c).toEqual(0);
});
