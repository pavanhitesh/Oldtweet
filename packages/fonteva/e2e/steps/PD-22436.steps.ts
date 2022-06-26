/* eslint-disable @typescript-eslint/no-explicit-any */
import { Before, When, Then, DataTable, After } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Business_Group__c,
  Fields$OrderApi__Payment_Method__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Subscription__c,
} from '../../fonteva-schema';
import { contactPage } from '../../pages/salesforce/contact.page';
import { conn } from '../../shared/helpers/force.helper';
import { termAssignmentsPage } from '../../pages/salesforce/term-assignments.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28764' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28764' }, async () => {
  const subscriptionId = (
    await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT Id FROM OrderApi__Subscription__c WHERE OrderApi__Sales_Order_Line__c IN
      (SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}')`,
    )
  ).records[0].Id;
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(subscriptionId as string);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(localSharedData.salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

When('User {string} makes payment for the Orders created', async (contactName: string) => {
  const salesOrderIdsList = (await browser.sharedStore.get('salesOrderIds')) as string[];

  await salesOrderIdsList.reduce(async (memo: any, salesOrderId: string) => {
    await memo;
    const salesOrderData = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Business_Group__c, OrderApi__Contact__c, OrderApi__Balance_Due__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrderId}'`,
      )
    ).records[0];

    const businessGroupData = (
      await conn.query<Fields$OrderApi__Business_Group__c>(
        `SELECT OrderApi__Default_Payment_Gateway__c, OrderApi__Invoice_OverPayment_Credit_Memo_Limit__c FROM OrderApi__Business_Group__c WHERE Id = '${salesOrderData.OrderApi__Business_Group__c}'`,
      )
    ).records[0];

    await contactPage.deletePaymentMethod(contactName);
    await contactPage.addNewPaymentMethod(contactName, 'visa', '1111');

    const paymentMethodData = (
      await conn.query<Fields$OrderApi__Payment_Method__c>(
        `SELECT Id, OrderApi__Payment_Method_Token__c FROM OrderApi__Payment_Method__c WHERE OrderApi__Contact__c = '${salesOrderData.OrderApi__Contact__c}'`,
      )
    ).records[0];

    await browser.sharedStore.set('paymentMethodId', paymentMethodData.Id);

    const paymentResponse = (
      await conn.apex.post<any>('/services/apexrest/FDService/OrderPaymentService', {
        orders: [
          {
            id: salesOrderId,
            paymentAmount: salesOrderData.OrderApi__Balance_Due__c as number,
          },
        ],
        contact: salesOrderData.OrderApi__Contact__c,
        paymentGateway: businessGroupData.OrderApi__Default_Payment_Gateway__c,
        paymentMethod: paymentMethodData.Id,
        paymentMethodToken: paymentMethodData.OrderApi__Payment_Method_Token__c,
      })
    ).data;

    expect(paymentResponse.receiptId).not.toBe(null);
  }, undefined);
});

Then(
  `User tries to add more subscribers than max allowed to the term and validates the error`,
  async (subscriberNames: DataTable) => {
    localSharedData.salesOrderId = await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0];
    const termId = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT Id FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}'`,
      )
    ).records[0].Id;
    const subscribers = subscriberNames.hashes();
    let subscriberCount = 0;
    await subscribers.reduce(async (memo, subscriberDetails) => {
      await memo;
      subscriberCount += 1;
      await termAssignmentsPage.open(
        `/lightning/r/OrderApi__Renewal__c/${termId}/related/OrderApi__Assignments__r/view`,
      );
      await termAssignmentsPage.waitForClickable(await termAssignmentsPage.newButton);
      await termAssignmentsPage.click(await termAssignmentsPage.newButton);
      await termAssignmentsPage.slowTypeFlex(await termAssignmentsPage.contact, subscriberDetails.Name);
      termAssignmentsPage.contactName = subscriberDetails.Name;
      await termAssignmentsPage.click(await termAssignmentsPage.contactNameOption);
      await termAssignmentsPage.click(await termAssignmentsPage.save);
      if (subscriberCount === 2) {
        const actualAlertText = await termAssignmentsPage.getText(await termAssignmentsPage.maxAssignmentsAlert);
        expect(actualAlertText).toBe(
          'You have reached the maximum number of allowed assignments. To add an additional active assignment, you must deactivate another.',
        );
      }
    }, undefined);
  },
);
