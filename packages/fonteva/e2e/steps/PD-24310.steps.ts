import { Before, Then, After } from '@cucumber/cucumber';
import moment from 'moment';
import { format } from 'date-fns';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Transaction_Line__c,
  Fields$OrderApi__Transaction__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-30549' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-30549' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('SalesOrderId')) as string);
  expect(deleteSO.success).toEqual(true);
});

Then(
  'User verifies debit, credit accounts and 13 transaction records are created with date value as end of month',
  async () => {
    await loginPage.sleep(MilliSeconds.XS);

    const itemDetails = (
      await conn.query<Fields$OrderApi__Item__c>(
        `Select OrderApi__Income_Account__c,OrderApi__Deferred_Revenue_Account__c from OrderApi__Item__c where Name = '${await browser.sharedStore.get(
          'itemName',
        )}'`,
      )
    ).records[0];

    const revenueRecognitionTransactions = (
      await conn.query<Fields$OrderApi__Transaction__c>(
        `SELECT OrderApi__Date__c ,Id FROM OrderApi__Transaction__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'SalesOrderId',
        )}' AND OrderApi__Type__c = 'Revenue Recognition'`,
      )
    ).records;
    const currentTime = new Date();
    const currentMonth = currentTime.getMonth() + 1;
    const currentYear = currentTime.getFullYear();
    let monthCount = 0;
    revenueRecognitionTransactions.forEach(async (revenueRecognitionTransaction) => {
      const date = new Date(currentYear, currentMonth + monthCount, 0);
      expect(revenueRecognitionTransaction.OrderApi__Date__c).toEqual(format(date, 'yyyy-MM-dd') as string);
      monthCount += 1;

      const transactionLines = (
        await conn.query<Fields$OrderApi__Transaction_Line__c>(
          `Select OrderApi__GL_Account__c,OrderApi__Debit__c,OrderApi__Credit__c From OrderApi__Transaction_Line__c where OrderApi__Transaction__c = '${revenueRecognitionTransaction.Id}'`,
        )
      ).records;
      transactionLines.forEach((transactionLine) => {
        if (transactionLine.OrderApi__Debit__c === 0) {
          expect(transactionLine.OrderApi__GL_Account__c).toEqual(itemDetails.OrderApi__Deferred_Revenue_Account__c);
        } else {
          expect(transactionLine.OrderApi__GL_Account__c).toEqual(itemDetails.OrderApi__Income_Account__c);
        }
      });
    });

    const firstDayOfMonth = moment().startOf('month').format('yyyy-MM-DD');
    const currentDate = moment().format('yyyy-MM-DD');
    if (currentDate === firstDayOfMonth) {
      expect(revenueRecognitionTransactions.length).toEqual(12);
    } else {
      expect(revenueRecognitionTransactions.length).toEqual(13);
    }
  },
);
