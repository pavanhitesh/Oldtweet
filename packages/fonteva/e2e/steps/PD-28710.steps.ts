import { Before, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-29347' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29347' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});
