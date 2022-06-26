/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Before, DataTable, Given, Then, When } from '@cucumber/cucumber';
import moment from 'moment';
import * as faker from 'faker';
import * as data from '../data/common-data.json';
import { loginPage } from '../../pages/salesforce/login.page';
import {
  Fields$OrderApi__Business_Group__c,
  Fields$OrderApi__GL_Account__c,
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28808' }, async () => {
  await loginPage.open('/');
  if (await loginPage.isDisplayed(await loginPage.username)) {
    await loginPage.login();
  }
});

After({ tags: '@TEST_PD-28808' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(salesOrderId);
  expect(deleteSO.success).toEqual(true);
  const deleteBatch = await conn.sobject('OrderApi__Batch__c').destroy(localSharedData.batchRecordId);
  expect(deleteBatch.success).toEqual(true);
});

Given(`User creates batch with the following information:`, async (batchCreationData: DataTable) => {
  const batchRecords = batchCreationData.hashes();
  await batchRecords.reduce(async (memo, batchData) => {
    await memo;

    const bussinessGroupId = (
      await conn.query<Fields$OrderApi__Business_Group__c>(
        `SELECT Id from OrderApi__Business_Group__c where Name = '${batchData.BusinessGroup}'`,
      )
    ).records[0].Id;

    localSharedData.depositAccountId = (
      await conn.query<Fields$OrderApi__GL_Account__c>(
        `SELECT Id FROM OrderApi__GL_Account__c WHERE Name = '${batchData.DepositAccount}'`,
      )
    ).records[0].Id;

    let defaultDate;
    if (batchData.DefaultDate === 'CurrentDate') {
      defaultDate = new Date(moment().format('MM/DD/YYYY'));
    } else if (batchData.DefaultDate === 'PastDate') {
      defaultDate = new Date(moment().add({ years: -1 }).format('MM/DD/YYYY'));
    } else if (batchData.DefaultDate === 'FutureDate') {
      defaultDate = new Date(moment().add({ years: 1 }).format('MM/DD/YYYY'));
    } else {
      defaultDate = new Date(batchData.DefaultDate);
    }

    let openedDate;
    if (batchData.OpenedDate === 'CurrentDate') {
      openedDate = new Date(moment().format('MM/DD/YYYY'));
    } else if (batchData.OpenedDate === 'PastDate') {
      openedDate = new Date(moment().add({ years: -1 }).format('MM/DD/YYYY'));
    } else if (batchData.OpenedDate === 'FutureDate') {
      openedDate = new Date(moment().add({ years: 1 }).format('MM/DD/YYYY'));
    } else {
      openedDate = new Date(batchData.OpenedDate);
    }

    localSharedData.batchName = `Delete_AutoBatch_${faker.name.firstName()}`;
    const batchRecordData = {
      Name: localSharedData.batchName,
      OrderApi__Business_Group__c: bussinessGroupId,
      OrderApi__Date__c: defaultDate,
      OrderApi__Deposit_Account__c: localSharedData.depositAccountId,
      OrderApi__Expected_Amount__c: parseFloat(batchData.ExpectedAmount),
      OrderApi__Expected_Count__c: parseFloat(batchData.ExpectedCount),
      OrderApi__Opened_Date__c: openedDate,
    };

    const batchCreationResponse: any = await conn.create('OrderApi__Batch__c', [batchRecordData]);
    expect(batchCreationResponse[0].success).toBe(true);
    localSharedData.batchRecordId = batchCreationResponse[0].id;
  }, undefined);
});

When(`User sends Proforma Invoice email`, async () => {
  await proformaInvoicePage.waitForPresence(await proformaInvoicePage.proformaInvoicePageHeader);
  await proformaInvoicePage.click(await proformaInvoicePage.sendEmail);
  await proformaInvoicePage.waitForPresence(await proformaInvoicePage.emailSentSuccessMessage);
  expect(await proformaInvoicePage.getText(await proformaInvoicePage.emailSentSuccessMessage)).toContain(
    'Your Email Has Been Sent.',
  );
});

When(`User navigates to apply payment page from SalesOrder`, async () => {
  await proformaInvoicePage.exitToSalesOrder();
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  await salesOrderPage.click(await salesOrderPage.applyPayment);
  await salesOrderPage.waitForPresence(await (await $('html')).shadow$('iframe[title="accessibility title"]'));
  await browser.switchToFrame(await (await $('html')).shadow$('iframe[title="accessibility title"]'));
  await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.applyPayment)).toEqual(true);
});

When(`User updates the batch and verifies the Deposit Account is updated`, async () => {
  await applyPaymentPage.selectBatch(localSharedData.batchName);
  expect(await applyPaymentPage.getValue(await applyPaymentPage.batchInput)).toBe(localSharedData.batchName);
  await applyPaymentPage.waitForElementToHaveValue(
    await applyPaymentPage.depositAccountDropDown,
    localSharedData.depositAccountId,
  );
  expect(await applyPaymentPage.getValue(await applyPaymentPage.depositAccountDropDown)).toBe(
    localSharedData.depositAccountId,
  );
});

Then(
  `User completes the payment using {string} and verifies the deposit account on Receipt`,
  async (paymentType: string) => {
    if (paymentType === 'Offline - Check') {
      await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentType);
      await applyPaymentPage.typeReferenceNumber(faker.finance.bic());
      await applyPaymentPage.click(await applyPaymentPage.applyPayment);
    } else if (paymentType === 'Credit Card') {
      await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentType);
      await applyPaymentPage.click(await applyPaymentPage.applyPayment);
      const cardName = faker.name.firstName();
      await applyPaymentPage.creditCardPayment(
        cardName,
        data.creditCardNumber,
        data.creditCardCVV,
        data.creditCardExpMonth,
        data.creditCardExpYear,
      );
      await applyPaymentPage.click(await applyPaymentPage.processPayment);
    }

    await applyPaymentPage.waitForPresence(await receiptPage.receiptNumber);
    expect(await receiptPage.isDisplayed(await receiptPage.receiptNumber)).toBe(true);

    const receiptDepositAccountId = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Deposit_Account__c FROM OrderApi__Receipt__c WHERE Name = '${await receiptPage.getText(
          await receiptPage.receiptNumber,
        )}'`,
      )
    ).records[0].OrderApi__Deposit_Account__c;

    expect(receiptDepositAccountId).toEqual(localSharedData.depositAccountId);
  },
);
