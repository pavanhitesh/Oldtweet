import { After, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';

After({ tags: '@TEST_PD-28470' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('portalSO')) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);
});

Then('User verifies the GLAccount field in the tax sales order line', async () => {
  const taxSalesOrderLine = (
    await conn.query(
      `SELECT OrderApi__GL_Account__c, OrderApi__Item__r.OrderApi__Income_Account__c FROM OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__c='${await browser.sharedStore.get(
        'portalSO',
      )}' AND OrderApi__Is_Tax__c =true`,
    )
  ).records[0];
  expect(taxSalesOrderLine.OrderApi__GL_Account__c).toEqual(
    taxSalesOrderLine.OrderApi__Item__r.OrderApi__Income_Account__c,
  );
});
