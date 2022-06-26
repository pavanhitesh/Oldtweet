/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Then, When } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Business_Group__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Payment_Method__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { conn } from '../../shared/helpers/force.helper';
import { orderPage } from '../../pages/portal/orders.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28535' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28535' }, async () => {
  const deleteSalesOrder = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderid as string);
  expect(deleteSalesOrder.success).toEqual(true);
});

When('User creates a new SOL with {string} and proceed for payment', async (itemName: string) => {
  localSharedData.salesOrderid = (await salesOrderPage.getUrl()).split('/')[6] as string;
  const itemId = (
    await conn.query<Fields$OrderApi__Item__c>(`Select Id from OrderApi__item__c where Name= '${itemName}'`)
  ).records[0].Id;
  const solResponse = await conn.create('OrderApi__Sales_Order_Line__c', {
    OrderApi__Sales_Order__c: localSharedData.salesOrderid,
    OrderApi__Item__c: itemId,
    OrderApi__Is_Adjustment__c: true,
    OrderApi__Is_Line_Posted__c: true,
  });
  expect(solResponse.success).toEqual(true);

  const lineItemsCountChk = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderid}'`,
    )
  ).records;
  expect(lineItemsCountChk.length).toEqual(2);

  await salesOrderPage.refreshBrowser();
  await salesOrderPage.click(await salesOrderPage.readyForPayment);
  await salesOrderPage.waitForPresence(await salesOrderPage.applyPayment);

  const salesOrderData = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Business_Group__c, OrderApi__Contact__c, OrderApi__Balance_Due__c FROM OrderApi__Sales_Order__c WHERE Id = '${localSharedData.salesOrderid}'`,
    )
  ).records[0];

  const businessGroupData = (
    await conn.query<Fields$OrderApi__Business_Group__c>(
      `SELECT OrderApi__Default_Payment_Gateway__c, OrderApi__Invoice_OverPayment_Credit_Memo_Limit__c FROM OrderApi__Business_Group__c WHERE Id = '${salesOrderData.OrderApi__Business_Group__c}'`,
    )
  ).records[0];

  const paymentMethodData = (
    await conn.query<Fields$OrderApi__Payment_Method__c>(
      `SELECT Id, OrderApi__Payment_Method_Token__c FROM OrderApi__Payment_Method__c WHERE OrderApi__Contact__c = '${salesOrderData.OrderApi__Contact__c}'`,
    )
  ).records[0];

  const paymentResponse = (
    await conn.apex.post<any>('/services/apexrest/FDService/OrderPaymentService', {
      orders: [
        {
          id: localSharedData.salesOrderid,
          paymentAmount: salesOrderData.OrderApi__Balance_Due__c as number,
        },
      ],
      contact: salesOrderData.OrderApi__Contact__c,
      paymentGateway: businessGroupData.OrderApi__Default_Payment_Gateway__c,
      paymentMethodId: paymentMethodData.Id,
      paymentMethodToken: paymentMethodData.OrderApi__Payment_Method_Token__c,
    })
  ).data;
  expect(paymentResponse.receiptId).not.toBe(null);
  localSharedData.receiptId = paymentResponse.receiptId;
});

Then('User verify there is no balance due on the receipt', async () => {
  const balanceDue = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `Select OrderApi__Balance__c from OrderApi__Receipt__c where Id = '${localSharedData.receiptId}'`,
    )
  ).records[0].OrderApi__Balance__c;
  expect(balanceDue).toEqual(0);
});
Then('User verifies no balance due displayed for the sales order and in the document', async () => {
  expect(await orderPage.getText(await orderPage.getBalanceDueOnAllOrders)).toEqual('$0.00');
  orderPage.viewOrders = (await browser.sharedStore.get('salesOrderId')) as string;
  await orderPage.click(await orderPage.viewOrderFromAllOrders);
  await orderPage.waitForPresence(await orderPage.balanceDueOnDocumnet);
  expect(await orderPage.getText(await orderPage.balanceDueOnDocumnet)).toEqual('$0.00');
});
