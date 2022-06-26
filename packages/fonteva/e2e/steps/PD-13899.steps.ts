import { Then, Before, After } from '@cucumber/cucumber';
import { format } from 'date-fns';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Renewal__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';

Before({ tags: '@TEST_PD-28837' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28837' }, async () => {
  const salesorders = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${await browser.sharedStore.get(
        'subscriptionToRenewBE',
      )}'`,
    )
  ).records;
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(`${await browser.sharedStore.get('subscriptionToRenewBE')}`);
  expect(deleteSubscription.success).toEqual(true);
  salesorders.forEach(async (salesOrder) => {
    const deleteSO = await conn
      .sobject('OrderApi__Sales_Order__c')
      .destroy(salesOrder.OrderApi__Sales_Order__c as string);
    expect(deleteSO.success).toEqual(true);
  });
});

Then('User verifies the next term renewed date on the previous term record', async () => {
  await applyPaymentPage.sleep(MilliSeconds.XXS);
  const termDetails = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Next_Term_Renewed_Date__c FROM OrderApi__Renewal__c WHERE OrderApi__Subscription__c = '${await browser.sharedStore.get(
        'subscriptionToRenewBE',
      )}'`,
    )
  ).records;
  expect(termDetails[termDetails.length - 2].OrderApi__Next_Term_Renewed_Date__c).toEqual(
    format(new Date(), 'yyyy-MM-dd'),
  );
});
