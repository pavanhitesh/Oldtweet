import { Before, Then, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Price_Rule__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';

Before({ tags: '@TEST_PD-29046' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29046' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then(
  'User verfies the {string} Price Rule is applied to optional packaged item {string}',
  async (ruleName: string, itemName: string) => {
    const configuredPrice = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${itemName}' and Name = '${ruleName}'`,
      )
    ).records[0].OrderApi__Price__c;
    const priceRule = `${ruleName} - $${configuredPrice}.00`;
    await rapidOrderEntryPage.expandItemtoViewDetails(itemName as string);
    await rapidOrderEntryPage.waitForAjaxCall();
    rapidOrderEntryPage.packagedItemName = itemName;
    await rapidOrderEntryPage.scrollToElement(await rapidOrderEntryPage.packagedItemPriceRuleDisplayed);
    const dspPriceRule = await rapidOrderEntryPage.getText(await rapidOrderEntryPage.packagedItemPriceRuleDisplayed);
    expect(priceRule).toEqual(dspPriceRule);
  },
);
