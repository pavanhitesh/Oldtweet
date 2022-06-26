import { After, Before } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-28534' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28534' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);

  const deleteCreditMemo = await conn.destroy(
    'OrderApi__Credit_Memo__c',
    (await browser.sharedStore.get('creditMemoId')) as string,
  );
  expect(deleteCreditMemo.success).toEqual(true);
});
