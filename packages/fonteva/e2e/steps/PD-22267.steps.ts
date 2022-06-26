import { When, Then, Before, After } from '@cucumber/cucumber';
import { lastDayOfYear, format, setYear } from 'date-fns';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Renewal__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28793' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28793' }, async () => {
  const renewalSubscription = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.renewalSOId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  const deleteRenewalSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(renewalSubscription);
  expect(deleteRenewalSubscription.success).toEqual(true);
  const deleteRenewalSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.renewalSOId);
  expect(deleteRenewalSO.success).toEqual(true);
  const originalSubscription = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.originalSOId}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(originalSubscription);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.originalSOId);
  expect(deleteSO.success).toEqual(true);
});

When(
  'User updates the subscription start date and end date to {string} year on {string} sales order line',
  async (year: number, salesOrderType: string) => {
    state.startDate = format(setYear(new Date(), year), 'MM/dd/yyyy');
    state.endDate = format(setYear(lastDayOfYear(new Date()), year), 'MM/dd/yyyy');
    let salesOrder = '';
    if (salesOrderType === 'original') {
      salesOrder = (
        await conn.query<Fields$OrderApi__Sales_Order__c>(
          `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
        )
      ).records[0].Id as string;
      state.originalSOId = salesOrder;
    } else if (salesOrderType === 'renewal') {
      salesOrder = await applyPaymentPage.getAttributeValue(
        await applyPaymentPage.orderDetailsTableRow,
        'data-row-key-value',
      );
      state.renewalSOId = salesOrder;
    }
    const activatedDate = await conn.tooling
      .executeAnonymous(`OrderApi__Sales_Order_Line__c record = [SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrder}'];
  record.OrderApi__Auto_Calculate_Activation_Date__c = false;
  record.OrderApi__Subscription_Start_Date__c = date.parse('${state.startDate}');
  record.OrderApi__Activation_Date__c = date.parse('${state.startDate}');
  record.OrderApi__End_Date__c = date.parse('${state.endDate}');
  update record;`);
    expect(activatedDate.success).toEqual(true);
  },
);

Then('User verifies the updated term start and end dates', async () => {
  await applyPaymentPage.sleep(MilliSeconds.XXS);
  const termDetails = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Term_End_Date__c, OrderApi__Term_Start_Date__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN
      (SELECT OrderApi__Sales_Order__c FROM orderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}')`,
    )
  ).records[0];
  expect(termDetails.OrderApi__Term_Start_Date__c).toEqual(format(new Date(state.startDate), 'yyyy-MM-dd'));
  expect(termDetails.OrderApi__Term_End_Date__c).toEqual(format(new Date(state.endDate), 'yyyy-MM-dd'));
});
