import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__EPayment__c, Fields$OrderApi__Receipt__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

let paymentReceiptId: string;

Before({ tags: '@TEST_PD-28250' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28250' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(`SELECT OrderApi__Sales_Order__c
FROM OrderApi__Receipt__c WHERE Name = '${paymentReceiptId}'`)
  ).records[0].OrderApi__Sales_Order__c;

  const salesOrderResponse = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderResponse.success).toEqual(true);
});

Then('User verifies the Gateway Transaction ID is populated for the refund e-payments receipt', async () => {
  paymentReceiptId = await receiptPage.getText(await receiptPage.receiptNumber);
  const paymentReceiptResponse = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Is_Payment__c FROM OrderApi__Receipt__c where Name = '${paymentReceiptId}'`,
    )
  ).records[0].OrderApi__Is_Payment__c;
  expect(paymentReceiptResponse).toEqual(true);

  await receiptPage.click(await receiptPage.createRefund);
  await receiptPage.waitForPresence(await receiptPage.buttonProcessRefund);
  await receiptPage.click(await receiptPage.buttonProcessRefund);
  await receiptPage.waitForPresence(await receiptPage.createRefund);

  const refundReceiptId = await receiptPage.getText(await receiptPage.receiptNumber);
  const refundReceiptResponse = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Process_Refund__c FROM OrderApi__Receipt__c where Name = '${refundReceiptId}'`,
    )
  ).records[0].OrderApi__Process_Refund__c;
  expect(refundReceiptResponse).toEqual(true);

  const gatewayTransactionId = (
    await conn.query<Fields$OrderApi__EPayment__c>(
      `SELECT OrderApi__Gateway_Transaction_ID__c from OrderApi__EPayment__c where Id in (SELECT OrderApi__EPayment__c from OrderApi__Receipt__c where Name = '${refundReceiptId}')`,
    )
  ).records[0].OrderApi__Gateway_Transaction_ID__c;
  expect(gatewayTransactionId).not.toBeNull();
});
