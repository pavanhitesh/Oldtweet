/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { accountPage } from '../../pages/salesforce/account.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import * as data from '../data/PD-27745.json';

Before({ tags: '@TEST_PD-28189' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
  await accountPage.deleteCreditMemo(data.AccountName);
});

After({ tags: '@TEST_PD-28189' }, async () => {
  await accountPage.deleteCreditMemo(data.AccountName);
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});

Then(`User verifies draft credit Memo amount is not displayed as available credit`, async () => {
  expect(await applyPaymentPage.getText(await applyPaymentPage.availableCredit)).toBe('$0.00');
});
