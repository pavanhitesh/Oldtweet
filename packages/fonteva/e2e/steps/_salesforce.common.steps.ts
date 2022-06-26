/* eslint-disable @typescript-eslint/no-explicit-any */
import { Given, When, DataTable, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import moment = require('moment');
import {
  Fields$Account,
  Fields$Contact,
  Fields$LTE__Site__c,
  Fields$OrderApi__Business_Group__c,
  Fields$OrderApi__Credit_Memo__c,
  Fields$OrderApi__Credit_Note__c,
  Fields$OrderApi__GL_Account__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Payment_Method__c,
  Fields$OrderApi__Price_Rule__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Store__c,
} from '../../fonteva-schema';
import { receiptPage } from '../../pages/salesforce/receipt.page';
import { contactPage } from '../../pages/salesforce/contact.page';
import { accountPage } from '../../pages/salesforce/account.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { taxAndShippingPage } from '../../pages/salesforce/tax-and-shipping.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { communitySitePage } from '../../pages/salesforce/community-site.page';
import { commonPage } from '../../pages/salesforce/_common.page';
import { conn } from '../../shared/helpers/force.helper';
import * as data from '../data/common-data.json';
import { proformaInvoicePage } from '../../pages/salesforce/proforma-invoice.page';
import { createInvoicePage } from '../../pages/salesforce/create-Invoice.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { priceRulePage } from '../../pages/salesforce/price-rule.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { commonPortalPage } from '../../pages/portal/common.page';
import { orderPage } from '../../pages/portal/orders.page';

Given('User will select {string} contact', async (contactName: string) => {
  browser.sharedStore.set('contactName', contactName);
  const records = (await conn.query<Fields$Contact>(`SELECT Id, AccountId FROM Contact WHERE Name='${contactName}'`))
    .records[0];
  browser.sharedStore.set('contactId', records.Id);
  browser.sharedStore.set('accountId', records.AccountId);
  await contactPage.openContactPage(records.Id);
  expect(await contactPage.getText(await contactPage.contactName)).toContain(contactName);
});

Given('User will select {string} account', async (accountName) => {
  const { Id } = (await conn.query<Fields$Account>(`SELECT Id FROM Account WHERE Name='${accountName}'`)).records[0];
  await accountPage.openAccountPage(Id);
  expect(await accountPage.getText(await accountPage.accountName)).toContain(accountName);
  await browser.sharedStore.set('accountId', Id);
});

Given(`All salesOrders from contact {string} are deleted`, async (contactName: string) => {
  await contactPage.deleteSalesOrder(contactName);
});

When('User opens the Rapid Order Entry page from contact', async () => {
  await contactPage.openRapidOrderEntryPage();
  expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.itemQuickAddTextBox)).toBe(true);
});

When('User opens the Rapid Order Entry page from account', async () => {
  await accountPage.openRapidOrderEntryPage();
  expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.itemQuickAddTextBox)).toBe(true);
});

When('User opens the Rapid Order Entry page from sales order', async () => {
  await salesOrderPage.openRapidOrderEntryPage();
  expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.itemQuickAddTextBox)).toBe(true);
});

Given('User should be able to add {string} item on rapid order entry', async (itemToAdd: string) => {
  await browser.sharedStore.set(
    'SalesOrderNumber',
    await (await rapidOrderEntryPage.getText(await rapidOrderEntryPage.salesOrderNumber)).replace('#', ''),
  );
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  await browser.sharedStore.set('SalesOrderId', salesOrderId);
  await rapidOrderEntryPage.addItemToOrder(itemToAdd);
  await rapidOrderEntryPage.waitForPresence(await rapidOrderEntryPage.go);
  expect(await rapidOrderEntryPage.verifyItemAddedToOrder(itemToAdd)).toBe(true);
  await browser.sharedStore.set('itemName', itemToAdd);
});

Given(
  'User should be able to add {string} item with {string} plan on rapid order entry',
  async (itemToAdd: string, subscriptionPlan: string) => {
    await browser.sharedStore.set(
      'SalesOrderNumber',
      await (await rapidOrderEntryPage.getText(await rapidOrderEntryPage.salesOrderNumber)).replace('#', ''),
    );
    const salesOrderId = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
      )
    ).records[0].Id;
    await browser.sharedStore.set('SalesOrderId', salesOrderId);
    await rapidOrderEntryPage.addItemToOrder(itemToAdd, 1, subscriptionPlan);
    await rapidOrderEntryPage.waitForPresence(await rapidOrderEntryPage.go);
    expect(await rapidOrderEntryPage.verifyItemAddedToOrder(itemToAdd)).toBe(true);
    await browser.sharedStore.set('itemName', itemToAdd);
  },
);

Given('User navigate to {string} page for {string} item from rapid order entry', async (page: string, item: string) => {
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.go);
  const { records } = await conn.query<Fields$OrderApi__Item__c>(
    `Select Id,OrderApi__Is_Taxable__c, OrderApi__Require_Shipping__c from OrderApi__item__c where Name= '${item}'`,
  );
  const itemConfig = records[0];
  browser.sharedStore.set('itemId', itemConfig.Id);

  if ((itemConfig.OrderApi__Is_Taxable__c || itemConfig.OrderApi__Require_Shipping__c) === true) {
    await taxAndShippingPage.waitForClickable(await taxAndShippingPage.title);
    expect(await (await taxAndShippingPage.continue).isDisplayed()).toEqual(true);
    if (page === 'apply payment') {
      await taxAndShippingPage.click(await taxAndShippingPage.continue);
      await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
      expect(await (await applyPaymentPage.balanceDueAmount).isDisplayed()).toEqual(true);
    } else if (page === 'Shipping and Tax') {
      await taxAndShippingPage.waitForClickable(await taxAndShippingPage.continue);
      expect(await taxAndShippingPage.isDisplayed(await taxAndShippingPage.title)).toBe(true);
    }
  } else {
    await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
    expect(await (await applyPaymentPage.balanceDueAmount).isDisplayed()).toEqual(true);
  }
});

When('User selects {string} as payment method and proceeds further', async (paymentType) => {
  await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther(paymentType);
  if (paymentType === 'Proforma Invoice') {
    await proformaInvoicePage.waitForPresence(await proformaInvoicePage.proformaInvoicePageHeader);
    expect(await proformaInvoicePage.isDisplayed(await proformaInvoicePage.proformaInvoicePageHeader)).toBe(true);
  } else if (paymentType === 'Invoice') {
    await createInvoicePage.click(await createInvoicePage.readyForPaymentButton);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
    expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
  } else if (paymentType === 'Process Payment') {
    await rapidOrderEntryPage.waitForPresence(await applyPaymentPage.applyPaymentPageHeader);
    expect(await rapidOrderEntryPage.isDisplayed(await applyPaymentPage.applyPaymentPageHeader)).toBe(true);
  }
});

Given(
  'User should be able to apply payment for {string} item using {string} payment on apply payment page',
  async (item: string, paymentType: string) => {
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
    await applyPaymentPage.waitForPresence(await receiptPage.receiptNumber);
    expect(await receiptPage.isDisplayed(await receiptPage.receiptNumber)).toBe(true);
    browser.sharedStore.set('receiptNameROE', await receiptPage.receiptNumber.getText());
  },
);

Given(`User opens the Price rule for {string} Item`, async (itemName: string) => {
  const { Id } = (
    await conn.query<Fields$OrderApi__Price_Rule__c>(`SELECT Id FROM OrderApi__Price_Rule__c WHERE OrderApi__Item__c In (SELECT Id FROM OrderApi__Item__c WHERE Name = '${itemName}')
`)
  ).records[0];
  await priceRulePage.openPriceRulePage(Id);
  await priceRulePage.waitForAjaxCall();
  expect(await priceRulePage.isDisplayed(await priceRulePage.cancel)).toBe(true);
});

Given(`User creates salesOrders with information provided below:`, async (orderCreationData: DataTable) => {
  const salesOrderNumbers: string[] = [];
  const dataTable = orderCreationData.hashes();
  await dataTable.reduce(async (memo, orderData) => {
    await memo;
    const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${orderData.Contact}'`))
      .records[0].Id;
    const accountId = (await conn.query<Fields$Account>(`Select Id from Account Where Name = '${orderData.Account}'`))
      .records[0].Id;
    const businessGroupId = (
      await conn.query<Fields$OrderApi__Business_Group__c>(
        `Select Id from OrderApi__Business_Group__c Where Name = '${orderData.BusinessGroup}'`,
      )
    ).records[0].Id;
    const itemId = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT Id from OrderApi__Item__c WHERE NAME = '${orderData.ItemName}'`,
      )
    ).records[0].Id;

    const orderServiceResponse = (
      await conn.apex.post<any>('/services/apexrest/FDService/OrderService', {
        contact: contactId,
        account: accountId,
        entity: orderData.Entity,
        businessGroup: businessGroupId,
        postingEntity: orderData.PostingEntity,
        scheduleType: orderData.ScheduleType,
        lines: [
          {
            item: itemId,
            contact: contactId,
            account: accountId,
            quantity: orderData.Qty,
            priceOverride: false,
            calculateShippingDetails: true,
            systemOverride: false,
            isRequiredPackageItem: false,
            isAdjustment: false,
            paymentPriority: 1,
          },
        ],
      })
    ).data;
    expect(await orderServiceResponse.lines[0].salesOrder).not.toBe('');
    salesOrderNumbers.push(await orderServiceResponse.lines[0].salesOrder);
  }, undefined);
  await browser.sharedStore.set('salesOrderIds', salesOrderNumbers);
});

When(`User marks the created orders as ready for payment`, async () => {
  const salesOrdersList = (await browser.sharedStore.get('salesOrderIds')) as string[];
  for (let i = 0; i < salesOrdersList.length; i += 1) {
    const postingEntity = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Posting_Entity__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrdersList[i]}'`,
      )
    ).records[0].OrderApi__Posting_Entity__c;
    if (postingEntity === 'Receipt') {
      const receiptUpdateResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c receiptOrder = [Select OrderApi__Is_Proforma__c, OrderApi__Is_Closed__c from OrderApi__Sales_Order__c Where Id = '${salesOrdersList[i]}'];
  receiptOrder.OrderApi__Is_Proforma__c = true;
  receiptOrder.OrderApi__Is_Closed__c = true;
  update receiptOrder;`);
      expect(receiptUpdateResponse.success).toEqual(true);
      await browser.sharedStore.set('SalesOrderId', salesOrdersList[i]);
    } else {
      const invoiceUpdateResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c invoiceOrder = [Select OrderApi__Is_Posted__c, OrderApi__Is_Closed__c from OrderApi__Sales_Order__c Where Id = '${salesOrdersList[i]}'];
  invoiceOrder.OrderApi__Is_Posted__c = true;
  invoiceOrder.OrderApi__Is_Closed__c = true;
  update invoiceOrder;`);
      expect(invoiceUpdateResponse.success).toEqual(true);
      await browser.sharedStore.set('SalesOrderId', salesOrdersList[i]);
    }
  }
});

Given(`User creates Credit Memo with below information:`, async (creditMemos: DataTable) => {
  const creditMemoData = creditMemos.hashes();
  await creditMemoData.reduce(async (memo, memoData) => {
    await memo;

    const accountId = (await conn.query<Fields$Account>(`Select Id from Account Where Name = '${memoData.Account}'`))
      .records[0].Id;

    const bussinessGroupId = (
      await conn.query<Fields$OrderApi__Business_Group__c>(
        `SELECT Id from OrderApi__Business_Group__c where Name = '${memoData.BusinessGroup}'`,
      )
    ).records[0].Id;

    const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${memoData.Contact}'`))
      .records[0].Id;

    const debitAccountId = (
      await conn.query<Fields$OrderApi__GL_Account__c>(
        `SELECT Id FROM OrderApi__GL_Account__c WHERE Name = '${memoData.DebitAccount}'`,
      )
    ).records[0].Id;

    const creditAccountId = (
      await conn.query<Fields$OrderApi__GL_Account__c>(
        `SELECT Id FROM OrderApi__GL_Account__c WHERE Name = '${memoData.CreditAccount}'`,
      )
    ).records[0].Id;

    let postedDate;
    if (memoData.PostedDate === 'CurrentDate') {
      postedDate = new Date(moment().format('MM/DD/YYYY'));
    } else if (memoData.PostedDate === 'PastDate') {
      postedDate = new Date(moment().add({ years: -1 }).format('MM/DD/YYYY'));
    } else if (memoData.PostedDate === 'FutureDate') {
      postedDate = new Date(moment().add({ years: 1 }).format('MM/DD/YYYY'));
    } else {
      postedDate = new Date(memoData.PostedDate);
    }

    const creditMemoCreationData = {
      OrderApi__Account__c: accountId,
      OrderApi__Business_Group__c: bussinessGroupId,
      OrderApi__Contact__c: contactId,
      OrderApi__Status__c: memoData.Status,
      OrderApi__Entity__c: memoData.Entity,
      OrderApi__Amount__c: memoData.Amount,
      OrderApi__Posted_Date__c: postedDate,
      OrderApi__Is_Posted__c: memoData.isPosted,
      OrderApi__Debit_Account__c: debitAccountId,
      OrderApi__Credit_Account__c: creditAccountId,
    };

    const creditMemoCreationResponse: any = await conn.create('OrderApi__Credit_Memo__c', [creditMemoCreationData]);
    expect(creditMemoCreationResponse[0].success).toBe(true);
  }, undefined);
});

Given('User should navigate to {string} Community Site', async (siteName: string) => {
  const communitySiteId = await (
    await conn.query<Fields$LTE__Site__c>(`SELECT Id FROM LTE__Site__c WHERE Name='${siteName}'`)
  ).records[0].Id;
  commonPage.openCommunitySitePage(communitySiteId);
  expect(await communitySitePage.getText(await communitySitePage.communityHeader)).toContain(siteName);
});

When(
  'User {string} makes {string} payment for the created order',
  async (contactName: string, paymentValue: string) => {
    const salesOrderData = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT Id, OrderApi__Business_Group__c, OrderApi__Contact__c, OrderApi__Balance_Due__c FROM OrderApi__Sales_Order__c WHERE Id = '${await browser.sharedStore.get(
          'SalesOrderId',
        )}'`,
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

    let paymentAmountValue;

    if (paymentValue === 'Extra') {
      await browser.sharedStore.set(
        'overPayAmount',
        faker.datatype.number({ min: 10, max: 50 }) +
          (businessGroupData.OrderApi__Invoice_OverPayment_Credit_Memo_Limit__c as number),
      );

      paymentAmountValue =
        (salesOrderData.OrderApi__Balance_Due__c as number) +
        ((await browser.sharedStore.get('overPayAmount')) as number);
    } else {
      paymentAmountValue = salesOrderData.OrderApi__Balance_Due__c as number;
    }
    const paymentResponse = (
      await conn.apex.post<any>('/services/apexrest/FDService/OrderPaymentService', {
        orders: [
          {
            id: salesOrderData.Id,
            paymentAmount: paymentAmountValue,
          },
        ],
        contact: salesOrderData.OrderApi__Contact__c,
        paymentGateway: businessGroupData.OrderApi__Default_Payment_Gateway__c,
        paymentMethod: paymentMethodData.Id,
        paymentMethodToken: paymentMethodData.OrderApi__Payment_Method_Token__c,
      })
    ).data;
    expect(paymentResponse.receiptId).not.toBe(null);
  },
);

Then(`User creates Credit Memo for the order`, async () => {
  await salesOrderPage.refreshBrowser();
  await salesOrderPage.waitForClickable(await salesOrderPage.moreActions);
  await salesOrderPage.click(await salesOrderPage.moreActions);
  await salesOrderPage.sleep(MilliSeconds.XXXS); // Adding this just to see the More Actions Opened and avoid any issues for clicking
  await salesOrderPage.click(await salesOrderPage.createCreditMemo);
  await salesOrderPage.waitForPresence(await salesOrderPage.moreActions);
  await salesOrderPage.sleep(MilliSeconds.XS); // Adding below lines for the Data to be created and avoid Errors
  await salesOrderPage.refreshBrowser();
  await salesOrderPage.waitForPresence(await salesOrderPage.moreActions);

  const creditMemoInfo = (
    await conn.query<Fields$OrderApi__Credit_Memo__c>(
      `SELECT Id, OrderApi__Amount__c FROM OrderApi__Credit_Memo__c WHERE OrderApi__Sales_Order__c IN
        (SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}')`,
    )
  ).records;

  await browser.sharedStore.set('creditMemoId', creditMemoInfo[0].Id);
  expect(creditMemoInfo.length).toEqual(1);
});

When(
  'User is able to expand the Item details of {string} and select the Additional Package item',
  async (itemName: string) => {
    await rapidOrderEntryPage.updateOptionalPackageItemQty(itemName, 1);
    expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.optionalItemPriceText)).toEqual(true);
  },
);

Given('User creates payment types with below information:', async (paymentTypeDetails: DataTable) => {
  const paymentTypeNames: string[] = [];
  const paymentTypeData = paymentTypeDetails.hashes();
  await paymentTypeData.reduce(async (memo, paymentRecord) => {
    await memo;
    const storeData = (
      await conn.query<Fields$OrderApi__Store__c>(
        `SELECT Id,OrderApi__Gateway__c FROM OrderApi__Store__c WHERE Name ='${paymentRecord.Store}'`,
      )
    ).records[0];

    const createPaymentType = `OrderApi__Custom_Payment_Type__c paymentType = new OrderApi__Custom_Payment_Type__c();
    paymentType.Name = '${paymentRecord.PaymentTypeName}';
    paymentType.OrderApi__Is_Enabled__c = ${paymentRecord.IsEnabled};
    paymentType.OrderApi__Store__c = '${storeData.Id}';
	  paymentType.OrderApi__Custom_Payment_Type_Template__c = '${paymentRecord.PaymentTypeTemplate}';
    paymentType.OrderApi__Payment_Gateway__c = '${storeData.OrderApi__Gateway__c}';
	  paymentType.OrderApi__Instructions__c = '${paymentRecord.Instructions}';
	  paymentType.OrderApi__Display_On_Backend_Checkout__c = ${paymentRecord.DisplayOnBackEndCheckout};
    paymentType.OrderApi__Display_On_Frontend_Checkout__c = ${paymentRecord.DisplayOnFrontEndCheckout};
    paymentType.OrderApi__Display_Order__c = ${paymentRecord.DisplayOrder};
    Insert paymentType;`;
    const createPaymentTyperesponse = await conn.tooling.executeAnonymous(createPaymentType);
    expect(createPaymentTyperesponse.success).toEqual(true);

    paymentTypeNames.push(paymentRecord.PaymentTypeName);
  }, undefined);
  await browser.sharedStore.set('paymentTypeNames', paymentTypeNames);
});

When(`User Posts the Credit Note`, async () => {
  const postCreditNoteQuery = `OrderApi__Credit_Note__c creditNote = [SELECT Id, OrderApi__Is_Posted__c FROM OrderApi__Credit_Note__c WHERE Id = '${await browser.sharedStore.get(
    'creditNoteId',
  )}'];
    creditNote.OrderApi__Is_Posted__c = true;
    update creditNote;`;
  await conn.tooling.executeAnonymous(postCreditNoteQuery);

  const isCreditNotePosted = (
    await conn.query<Fields$OrderApi__Credit_Note__c>(
      `SELECT OrderApi__Is_Posted__c FROM OrderApi__Credit_Note__c WHERE Id = '${await browser.sharedStore.get(
        'creditNoteId',
      )}'`,
    )
  ).records[0].OrderApi__Is_Posted__c;

  expect(isCreditNotePosted).toBe(true);
});

When('User creates creditNotes for the sales order Line item created using {string}', async (orderType: string) => {
  let salesOrderId;
  if (orderType === 'ROE') {
    salesOrderId = await (await salesOrderPage.getUrl()).split('/OrderApi__Sales_Order__c/')[1].split('/')[0];
  } else if (orderType === 'OrderService') {
    salesOrderId = await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0];
  }

  const salesOrderLineItemDetails = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`SELECT Id,
    OrderApi__Overall_Total__c,
    OrderApi__Balance_Due__c,
    OrderApi__Item__c,
    OrderApi__Quantity__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'`)
  ).records[0];

  const adjustmentLineData = (
    await conn.apex.post<any>('/services/apexrest/FDService/AdjustmentService', {
      type: 'adjustment',
      adjustmentType: 'negative',
      recordType: 'orderline',
      records: [
        {
          id: salesOrderLineItemDetails.Id,
          salesOrder: salesOrderId,
          item: salesOrderLineItemDetails.OrderApi__Item__c,
          balanceDue: salesOrderLineItemDetails.OrderApi__Balance_Due__c,
          overallTotal: salesOrderLineItemDetails.OrderApi__Overall_Total__c,
          isAdjustment: false,
        },
      ],
    })
  ).data;

  await browser.sharedStore.set('AdjustmentLineId', adjustmentLineData[0].id as string);

  const creditNoteData = (
    await conn.apex.post<any>('/services/apexrest/FDService/AdjustmentService', {
      type: 'creditnote',
      recordType: 'orderline',
      records: adjustmentLineData,
    })
  ).data;

  await browser.sharedStore.set('creditNoteId', creditNoteData[0].id as string);

  const lineItemsCountChk = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'`,
    )
  ).records;

  const creditNoteCreationChk = (
    await conn.query<Fields$OrderApi__Credit_Note__c>(
      `SELECT Id FROM OrderApi__Credit_Note__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'`,
    )
  ).records;

  expect(lineItemsCountChk.length).toEqual(2);
  expect(creditNoteCreationChk.length).toEqual(1);
});

Then('User navigate to All Orders Tab', async () => {
  await commonPortalPage.openOrderLinks();
  await orderPage.clickAllOrdersTab();
  expect(await orderPage.isDisplayed(await orderPage.getBalanceDueOnAllOrders)).toEqual(true);
});
