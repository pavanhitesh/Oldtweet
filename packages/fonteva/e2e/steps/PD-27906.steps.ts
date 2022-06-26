/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable no-restricted-syntax */
import { After, Before, When } from '@cucumber/cucumber';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$OrderApi__Credit_Note__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { salesOrderLinePage } from '../../pages/salesforce/salesorderline.page';
import * as data from '../data/PD-27906.json';
import { commonPage } from '../../pages/salesforce/_common.page';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@TEST_PD-28237' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28237' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(salesOrderDeleted.success).toEqual(true);
});

When('User creates creditNotes for the packaged sales order Line item', async () => {
  const url = await salesOrderPage.getUrl();
  const salesOrderId = url.split('/OrderApi__Sales_Order__c/')[1].split('/')[0];
  localSharedData.salesOrderId = salesOrderId;
  const salesOrderLineItemDetails = await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`SELECT Id,
    OrderApi__Overall_Total__c,
    OrderApi__Balance_Due__c,
    OrderApi__Item__c,
    OrderApi__Quantity__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'
    AND OrderApi__Display_Item__c =true AND OrderApi__Sales_Order_Line__c <> null`);

  expect(salesOrderLineItemDetails.records.length).toBeGreaterThanOrEqual(2);

  const adjustmentLineData = (
    await conn.apex.post<any>('/services/apexrest/FDService/AdjustmentService', {
      type: 'adjustment',
      adjustmentType: 'negative',
      recordType: 'orderline',
      records: [
        {
          id: salesOrderLineItemDetails.records[0].Id,
          salesOrder: salesOrderId,
          item: salesOrderLineItemDetails.records[0].OrderApi__Item__c,
          balanceDue: salesOrderLineItemDetails.records[0].OrderApi__Balance_Due__c,
          overallTotal: salesOrderLineItemDetails.records[0].OrderApi__Overall_Total__c,
          isAdjustment: false,
        },
        {
          id: salesOrderLineItemDetails.records[1].Id,
          salesOrder: salesOrderId,
          item: salesOrderLineItemDetails.records[1].OrderApi__Item__c,
          balanceDue: salesOrderLineItemDetails.records[1].OrderApi__Balance_Due__c,
          overallTotal: salesOrderLineItemDetails.records[1].OrderApi__Overall_Total__c,
          isAdjustment: false,
        },
      ],
    })
  ).data;

  localSharedData.AdjustmentLineId = `${adjustmentLineData[0].id},${adjustmentLineData[1].id}`;

  const creditNoteData = (
    await conn.apex.post<any>('/services/apexrest/FDService/AdjustmentService', {
      type: 'creditnote',
      recordType: 'orderline',
      records: adjustmentLineData,
    })
  ).data;

  localSharedData.creditNoteId = creditNoteData[0].id;

  const lineItemsCountChk = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrderId}'  AND OrderApi__Is_Adjustment__c =true`,
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

When('User updates the Adjustment line Item Deffered revenue and verify', async () => {
  const adjustmentLineIds = localSharedData.AdjustmentLineId.toString().split(',');
  for (const adjustmentLineId of adjustmentLineIds) {
    const originalAdjustmentLine = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT Id, OrderApi__Item__c FROM OrderApi__Sales_Order_Line__c Where Id = '${adjustmentLineId}'`,
      )
    ).records[0];
    await salesOrderLinePage.open(`/lightning/r/OrderApi__Sales_Order_Line__c/${originalAdjustmentLine.Id}/view`);
    await salesOrderLinePage.waitForPresence(await salesOrderLinePage.salesOrderLinePageHeader);
    await salesOrderLinePage.scrollToElement(await salesOrderLinePage.editDeferredRevenue);
    await salesOrderLinePage.click(await salesOrderLinePage.editDeferredRevenue);
    await salesOrderLinePage.sleep(MilliSeconds.XXS);
    await browser.keys('Space');
    await commonPage.click(await commonPage.save);
    await salesOrderLinePage.waitForAjaxCall();

    const isItemDefferred = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT Id, OrderApi__Defer_Revenue__c FROM OrderApi__Item__c Where Id = '${originalAdjustmentLine.OrderApi__Item__c}'`,
      )
    ).records[0].OrderApi__Defer_Revenue__c as boolean;
    if (isItemDefferred) {
      expect(await salesOrderLinePage.editDeferredRevenue.isDisplayed()).toBe(true);
    } else {
      expect(await commonPage.saveError.getText()).toContain(data.deferredError);
      await commonPage.click(await commonPage.cancel);
      expect(await salesOrderLinePage.editDeferredRevenue.isDisplayed()).toBe(true);
    }
  }
});
