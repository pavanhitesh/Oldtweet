import { After, Then } from '@cucumber/cucumber';
import {
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Sales_Order_Line__c,
} from '../../fonteva-schema';
import { commonPortalPage } from '../../pages/portal/common.page';
import { conn } from '../../shared/helpers/force.helper';

const state: { [key: string]: string } = {};

Then(
  'User should be able to remove {string} item with quantity {string} on store',
  async (item: string, quantity: number) => {
    await commonPortalPage.waitForPresence(await commonPortalPage.cartButton);
    await commonPortalPage.click(await commonPortalPage.cartButton);
    await commonPortalPage.waitForPresence(await commonPortalPage.viewCartButton);
    await commonPortalPage.click(await commonPortalPage.viewCartButton);
    const removeSalesOrderLine = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT Id, OrderApi__Sales_Order__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Item__r.Name = '${item}' AND OrderApi__Quantity__c = ${quantity} ORDER BY Name DESC`,
      )
    ).records[0];
    state.removeSalesOrderLine = removeSalesOrderLine.Id;
    state.salesOrderId = removeSalesOrderLine.OrderApi__Sales_Order__c;
    const deleteSOL = await conn.sobject('OrderApi__Sales_Order_Line__c').destroy(state.removeSalesOrderLine);
    expect(deleteSOL.success).toEqual(true);
    await browser.refresh();
  },
);

Then(
  'User should be able to verify in cart pricing for removed badge is reflected on the sales order where contact is {string} for {string} item',
  async (contact: string, item: string) => {
    const soPrice = (
      await conn.query<Fields$OrderApi__Sales_Order__c>(
        `SELECT OrderApi__Overall_Total__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
      )
    ).records[0].OrderApi__Overall_Total__c;
    const itemPrice = (
      await conn.query<Fields$OrderApi__Item__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Item__c WHERE OrderApi__Display_Name__c ='${item}'`,
      )
    ).records[0].OrderApi__Price__c;
    expect(soPrice).toEqual(itemPrice);
  },
);

After({ tags: '@TEST_PD-28281' }, async () => {
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId);
  expect(deleteSO.success).toEqual(true);
});
