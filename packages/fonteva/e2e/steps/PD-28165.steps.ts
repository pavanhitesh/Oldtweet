import { Before, Then, When, After } from '@cucumber/cucumber';
import {
  Fields$OrderApi__Price_Rule__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$OrderApi__Sales_Order__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { salesOrderLinePage } from '../../pages/salesforce/salesorderline.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29252' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User clicks on Exit button on rapid order entry', async () => {
  await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
  await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderPageHeader);
  localSharedData.salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  localSharedData.salesOrderLineID = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`
        Select Id from OrderApi__Sales_Order_Line__c Where OrderApi__Sales_Order__c= '${localSharedData.salesOrderId}'`)
  ).records[0].Id;
  expect(await salesOrderPage.isDisplayed(await salesOrderPage.salesOrderPageHeader)).toBe(true);
});

When(
  'User updates the Annual Engagement Score to {int} for {string} contact',
  async (annualEngagementScore: number, contactName: string) => {
    const aeScoreUpdateResponse = await conn.tooling.executeAnonymous(`
    Contact aeScore = [Select OrderApi__Annual_Engagement_Score__c from Contact Where Name = '${contactName}'];
    aeScore.OrderApi__Annual_Engagement_Score__c = ${annualEngagementScore};
   update aeScore;`);
    expect(aeScoreUpdateResponse.success).toEqual(true);
  },
);

When(
  'User verify price rule is populated or updated to {string} in sales order line',
  async (priceRuleName: string) => {
    const SOLPriceRuleId = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`
            Select OrderApi__Price_Rule__c from OrderApi__Sales_Order_Line__c Where OrderApi__Sales_Order__c
            = '${
              localSharedData.salesOrderId
            }' and OrderApi__Item__c IN (SELECT Id FROM OrderApi__Item__c WHERE Name = '${await browser.sharedStore.get(
        'itemName',
      )}')`)
    ).records[0].OrderApi__Price_Rule__c as string;

    const SOLPriceRuleNameId = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(`
              Select Id from OrderApi__Price_Rule__c Where Name = '${priceRuleName}' and OrderApi__Item__c IN (SELECT Id FROM OrderApi__Item__c WHERE Name = '${await browser.sharedStore.get(
        'itemName',
      )}')`)
    ).records[0].Id;
    expect(SOLPriceRuleNameId).toEqual(SOLPriceRuleId);
  },
);

Then('User performs dummy edit on sales order line and click on save', async () => {
  await salesOrderLinePage.open(`/lightning/r/OrderApi__Sales_Order_Line__c/${localSharedData.salesOrderLineID}/view`);
  await salesOrderLinePage.sleep(MilliSeconds.XXS);
  await salesOrderLinePage.waitForPresence(await salesOrderLinePage.salesOrderLinePageHeader);
  await salesOrderLinePage.click(await salesOrderLinePage.edit);
  await salesOrderLinePage.click(await salesOrderLinePage.saveEdit);
  await salesOrderLinePage.sleep(MilliSeconds.XXS);
  expect(await salesOrderLinePage.isDisplayed(await salesOrderLinePage.salesOrderLinePageHeader)).toBe(true);
});

After({ tags: '@TEST_PD-29252' }, async () => {
  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId);
  expect(deleteSO.success).toEqual(true);
});
