import { After, When } from '@cucumber/cucumber';
import {
  Fields$OrderApi__EPayment__c,
  Fields$OrderApi__Payment_Gateway__c,
  Fields$OrderApi__Receipt__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

When(
  'User should see {string} on Payment Gateway field in receipt and epayment record',
  async (paymentGatewayName: string) => {
    const orderApiReceiptResponse = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Payment_Gateway__c, OrderApi__EPayment__c  FROM OrderApi__Receipt__c  WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'portalSO',
        )}'`,
      )
    ).records[0];
    const paymentGatewayId = (
      await conn.query<Fields$OrderApi__Payment_Gateway__c>(
        `SELECT Id FROM OrderApi__Payment_Gateway__c WHERE Name='${paymentGatewayName}'`,
      )
    ).records[0].Id;
    expect(orderApiReceiptResponse.OrderApi__Payment_Gateway__c).toEqual(paymentGatewayId);

    const paymentGatewayIdFromReceipt = (
      await conn.query<Fields$OrderApi__EPayment__c>(
        `SELECT OrderApi__Payment_Gateway__c FROM OrderApi__EPayment__c WHERE Id ='${orderApiReceiptResponse.OrderApi__EPayment__c}'`,
      )
    ).records[0].OrderApi__Payment_Gateway__c;
    expect(paymentGatewayIdFromReceipt).toEqual(paymentGatewayId);
  },
);

After({ tags: '@TEST_PD-28845' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
});
