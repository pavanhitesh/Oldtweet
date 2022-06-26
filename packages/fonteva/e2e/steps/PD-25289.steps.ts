import { Before, Then, After } from '@cucumber/cucumber';
import moment from 'moment';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Transaction__c, Fields$OrderApi__Renewal__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-28459' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28459' }, async () => {
  const subscription = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
        'portalSO',
      )}'`,
    )
  ).records[0].OrderApi__Subscription__c;
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(subscription as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
});

Then('User verifies the revenue recognition type transactions created', async () => {
  await loginPage.sleep(MilliSeconds.XS);
  const revenueRecognitionTransactions = (
    await conn.query<Fields$OrderApi__Transaction__c>(
      `SELECT Id FROM OrderApi__Transaction__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
        'portalSO',
      )}' AND OrderApi__Type__c = 'Revenue Recognition'`,
    )
  ).records;
  const firstDayOfMonth = moment().startOf('month').format('yyyy-MM-DD');
  const currentDate = moment().format('yyyy-MM-DD');
  if (currentDate === firstDayOfMonth) {
    expect(revenueRecognitionTransactions.length).toEqual(12);
  } else {
    expect(revenueRecognitionTransactions.length).toEqual(13);
  }
});
