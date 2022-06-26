import { After, Before, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$OrderApi__Receipt__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';

Before({ tags: '@TEST_PD-29773' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29773' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then(`User verifies encypted field is populated on Receipt`, async () => {
  const encryptedId = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Encrypted_Id__c FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Encrypted_Id__c as string;
  expect(encryptedId).not.toBeNull();
});
