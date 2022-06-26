/* eslint-disable @typescript-eslint/no-explicit-any */
import { Before, When, Then, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Transaction_Line__c,
  Fields$OrderApi__Transaction__c,
} from '../../fonteva-schema';

Before({ tags: '@TEST_PD-27733' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27733' }, async () => {
  const deleteSO = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('SalesOrderId')) as string,
  );
  expect(deleteSO.success).toEqual(true);

  const deleteCreditMemo = await conn.destroy(
    'OrderApi__Credit_Memo__c',
    (await browser.sharedStore.get('creditMemoId')) as string,
  );
  expect(deleteCreditMemo.success).toEqual(true);

  const deleteCreditNote = await conn.destroy(
    'OrderApi__Credit_Note__c',
    (await browser.sharedStore.get('creditNoteId')) as string,
  );
  expect(deleteCreditNote.success).toEqual(true);
});

When(
  'User updates the Adjustment line Item sales Price such that Balance due is {string}',
  async (balanceDueType: string) => {
    const originalAdjustmentSalePrice = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Sale_Price__c FROM OrderApi__Sales_Order_Line__c Where Id = '${await browser.sharedStore.get(
          'AdjustmentLineId',
        )}'`,
      )
    ).records[0].OrderApi__Sale_Price__c as number;

    let updatedAdjustmentSalePrice;
    if (balanceDueType === 'negative') {
      // Reducing 20% of the price to salesprice to have balance due as negative
      updatedAdjustmentSalePrice = originalAdjustmentSalePrice - (20 * originalAdjustmentSalePrice) / 100;
    } else {
      // Adding 20% of the price to salesprice to have balance due as positive so that credit memo can be created
      updatedAdjustmentSalePrice = originalAdjustmentSalePrice + (20 * originalAdjustmentSalePrice) / 100;
    }

    const updateSOLQuery = `OrderApi__Sales_Order_Line__c SOL = [SELECT OrderApi__Sale_Price__c FROM OrderApi__Sales_Order_Line__c Where Id = '${await browser.sharedStore.get(
      'AdjustmentLineId',
    )}'];
    SOL.OrderApi__Sale_Price__c = ${updatedAdjustmentSalePrice};
    update SOL;`;
    await conn.tooling.executeAnonymous(updateSOLQuery);

    const afterUpdationAdjustmentSalePrice = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT OrderApi__Sale_Price__c FROM OrderApi__Sales_Order_Line__c Where Id = '${await browser.sharedStore.get(
          'AdjustmentLineId',
        )}'`,
      )
    ).records[0].OrderApi__Sale_Price__c as number;

    expect(afterUpdationAdjustmentSalePrice).toEqual(updatedAdjustmentSalePrice);
  },
);

Then(`User verifies the Balance Due on SalesOrder is zero`, async () => {
  const balanceDueOnSalesOrder = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Balance_Due__c FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Balance_Due__c as number;
  expect(balanceDueOnSalesOrder).toEqual(0);
});

Then(
  `User Verifies only one transaction created for credit memo and SalesOrder line is populated on Transaction lines`,
  async () => {
    const transactionsCheck = (
      await conn.query<Fields$OrderApi__Transaction__c>(
        `SELECT Id, OrderApi__Total_Credits__c, OrderApi__Total_Debits__c FROM OrderApi__Transaction__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
          'SalesOrderNumber',
        )}' AND OrderApi__Type__c = 'Credit Memo'`,
      )
    ).records;

    const expectedAmountValue = (await browser.sharedStore.get('overPayAmount')) as number;

    expect(transactionsCheck.length).toEqual(1);
    expect(transactionsCheck[0].OrderApi__Total_Credits__c).toEqual(expectedAmountValue);
    expect(transactionsCheck[0].OrderApi__Total_Debits__c).toEqual(expectedAmountValue);

    const transactionLineCheck = (
      await conn.query<Fields$OrderApi__Transaction_Line__c>(
        `SELECT OrderApi__Sales_Order_Line__c FROM OrderApi__Transaction_Line__c WHERE OrderApi__Transaction__c = '${transactionsCheck[0].Id}'`,
      )
    ).records;
    expect(transactionLineCheck.length).toEqual(2);
    expect(transactionLineCheck[0].OrderApi__Sales_Order_Line__c).not.toBeNull();
    expect(transactionLineCheck[1].OrderApi__Sales_Order_Line__c).not.toBeNull();
    expect(transactionLineCheck[0].OrderApi__Sales_Order_Line__c).toEqual(
      transactionLineCheck[1].OrderApi__Sales_Order_Line__c,
    );
  },
);
