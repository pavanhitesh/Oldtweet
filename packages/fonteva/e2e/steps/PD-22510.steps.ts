import { Before, Then, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Price_Rule__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { createInvoicePage } from '../../pages/salesforce/create-Invoice.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string | boolean } = {};

Before({ tags: '@TEST_PD-28822' }, async () => {
  await loginPage.open('/');
  if (await loginPage.isDisplayed(await loginPage.username)) {
    await loginPage.login();
  }
});

After({ tags: '@TEST_PD-28822' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

Then('User verfies the {string} Price Rule is applied to item {string}', async (ruleName: string, itemName: string) => {
  const configuredPrice = (
    await conn.query<Fields$OrderApi__Price_Rule__c>(
      `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${itemName}' and Name = '${ruleName}'`,
    )
  ).records[0].OrderApi__Price__c;
  localSharedData.price = `$${configuredPrice}.00`;
  const priceRule = `${ruleName} - $${configuredPrice}.00`;
  await rapidOrderEntryPage.expandItemtoViewDetails(itemName as string);
  await rapidOrderEntryPage.waitForAjaxCall();
  rapidOrderEntryPage.itemPriceRule = itemName;
  await rapidOrderEntryPage.sleep(MilliSeconds.XXS);
  await rapidOrderEntryPage.scrollToElement(await rapidOrderEntryPage.itemPriceRuleDisplayed);
  const dspPriceRule = await rapidOrderEntryPage.getText(await rapidOrderEntryPage.itemPriceRuleDisplayed);
  expect(dspPriceRule).toEqual(priceRule);
});

Then(
  'User selects "Invoice" as payment method and verifies Badge Price Rule is applied to item {string} in payment page',
  async (itemName: string) => {
    await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther('Invoice');
    createInvoicePage.itemPriceValueName = itemName;
    const itemPrice = await createInvoicePage.getText(await createInvoicePage.itemPriceValue);
    expect(itemPrice).toEqual(localSharedData.price);
  },
);

Then('User navigate back to ROE page and delete the item {string}', async (itemName: string) => {
  await createInvoicePage.click(await createInvoicePage.returnToPreviousPage);
  await rapidOrderEntryPage.removeItemFromOrder(itemName);
  expect(await rapidOrderEntryPage.verifyItemAddedToOrder(itemName)).toEqual(false);
});
