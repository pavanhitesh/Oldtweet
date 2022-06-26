import { Given, Before } from '@cucumber/cucumber';
import {
  Fields$OrderApi__EPayment_Line__c,
  Fields$OrderApi__Sales_Order_Line__c,
} from 'packages/fonteva/fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

Before({ tags: '@TEST_PD-27109' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given('User should be able to see the price rule on the epayment line', async () => {
  const receipt = await receiptPage.getText(await receiptPage.receiptNumber);
  const epaymentPriceRule = (
    await conn.query<Fields$OrderApi__EPayment_Line__c>(
      `SELECT OrderApi__Price_Rule__c FROM OrderApi__EPayment_Line__c WHERE OrderApi__EPayment__c IN
      (SELECT OrderApi__EPayment__c FROM OrderApi__Receipt__c WHERE Name = '${receipt}')`,
    )
  ).records[0].OrderApi__Price_Rule__c;
  const salesOrderLinePriceRule = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT OrderApi__Price_Rule__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c IN
      (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${receipt}')`,
    )
  ).records[0].OrderApi__Price_Rule__c;
  expect(epaymentPriceRule).toEqual(salesOrderLinePriceRule);
});
