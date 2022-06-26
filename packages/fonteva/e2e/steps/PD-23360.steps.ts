import { Before, After, Then } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Subscription__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

Before({ tags: '@TEST_PD-28991' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28991' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy((await browser.sharedStore.get('subscription')) as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('salesOrderId')) as string);
  expect(deleteSO.success).toEqual(true);
});

Then('User verifies the expired date is not showing for expired subscription', async () => {
  await receiptPage.sleep(MilliSeconds.XXS);
  const term = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT OrderApi__Expired_Date__c FROM OrderApi__Subscription__c WHERE Id = '${
        (await browser.sharedStore.get('subscription')) as string
      }'`,
    )
  ).records[0].OrderApi__Expired_Date__c;
  expect(term).toEqual(null);
});
