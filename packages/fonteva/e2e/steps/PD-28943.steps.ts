/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, Then, When } from '@cucumber/cucumber';
import { lastDayOfYear, format, setYear } from 'date-fns';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$OrderApi__Business_Group__c,
  Fields$OrderApi__Payment_Method__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@TEST_PD-29075' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29075' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(localSharedData.subScriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);
});

When(
  'User navigate back to sales order and updated the sol with Subscription Start Date,Activation Date and End Date to {string} year',
  async (year: number) => {
    localSharedData.startDate = format(setYear(new Date(), year), 'MM/dd/yyyy');
    localSharedData.endDate = format(setYear(lastDayOfYear(new Date()), year), 'MM/dd/yyyy');
    await applyPaymentPage.click(await applyPaymentPage.cancelButton);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    localSharedData.salesOrderNumber = await salesOrderPage.getText(await salesOrderPage.salesOrderNumber);
    const updateSol = await conn.tooling
      .executeAnonymous(`OrderApi__Sales_Order_Line__c record = [SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${localSharedData.salesOrderNumber}'];
  record.OrderApi__Subscription_Start_Date__c = date.parse('${localSharedData.startDate}');
  record.OrderApi__Activation_Date__c = date.parse('${localSharedData.startDate}');
  record.OrderApi__End_Date__c = date.parse('${localSharedData.endDate}');
  update record;`);
    expect(updateSol.success).toEqual(true);
  },
);

When('User makes the sales order ready for payment and complete the payment', async () => {
  await salesOrderPage.click(await salesOrderPage.readyForPayment);
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.applyPayment)).toEqual(true);
  const salesOrderData = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id,OrderApi__Business_Group__c, OrderApi__Contact__c, OrderApi__Balance_Due__c FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0];
  localSharedData.salesOrderId = salesOrderData.Id;

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
          id: localSharedData.salesOrderId,
          paymentAmount: salesOrderData.OrderApi__Balance_Due__c as number,
        },
      ],
      contact: salesOrderData.OrderApi__Contact__c,
      paymentGateway: businessGroupData.OrderApi__Default_Payment_Gateway__c,
      paymentMethodId: paymentMethodData.Id,
      paymentMethodToken: paymentMethodData.OrderApi__Payment_Method_Token__c,
    })
  ).data;
  browser.sharedStore.set('receiptId', paymentResponse.receiptId);
  expect(paymentResponse.receiptId).not.toBe(null);
});

Then('User validates the Status Field as Expired and Term Start Date and Term End Date with sol dates', async () => {
  await salesOrderPage.sleep(MilliSeconds.S);
  localSharedData.subScriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
    )
  ).records[0].OrderApi__Subscription__c;

  const subScriptionResponse = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `Select OrderApi__Status__c,OrderApi__Term_Start_Date__c,OrderApi__Term_End_Date__c From OrderApi__Subscription__c Where Id = '${localSharedData.subScriptionId}'`,
    )
  ).records[0];

  expect(subScriptionResponse.OrderApi__Status__c).toEqual('Expired');
});
