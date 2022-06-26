import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Receipt_Line__c, Fields$OrderApi__Receipt__c } from '../../fonteva-schema';
import { receiptLinePage } from '../../pages/salesforce/receipt-line.page';
import { receiptPage } from '../../pages/salesforce/receipt.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import * as data from '../data/PD-14495.json';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-27170' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User should create the refund for the item', async () => {
  await receiptPage.click(await receiptPage.createRefund);
  await receiptPage.sleep(MilliSeconds.XXS); // data creation
  await receiptPage.waitForPresence(await receiptPage.createRefund);
  state.salesOrderId = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}'`,
    )
  ).records[0].OrderApi__Sales_Order__c as string;
  const receiptLineId = (
    await conn.query<Fields$OrderApi__Receipt_Line__c>(
      `SELECT Id from OrderApi__Receipt_Line__c where OrderApi__Receipt__c IN (SELECT Id FROM OrderApi__Receipt__c WHERE OrderApi__Sales_Order__c='${state.salesOrderId}' and OrderApi__Type__c ='Refund')`,
    )
  ).records[0].Id;
  await receiptPage.open(`/lightning/r/OrderApi__Receipt_Line__c/${receiptLineId}/view`);
  await receiptLinePage.waitForPresence(await receiptLinePage.header);
  expect(await receiptLinePage.header.isDisplayed()).toEqual(true);
});

Then('User verifies validation message when negative quantity is entered on the receipt', async () => {
  await receiptLinePage.sleep(MilliSeconds.XXXS);
  await receiptLinePage.click(await receiptLinePage.itemQuantity);
  await receiptLinePage.sleep(MilliSeconds.XXXS);
  await receiptLinePage.slowTypeFlex(await receiptLinePage.inputQuantity, data.itemQuantity);
  await receiptLinePage.click(await receiptLinePage.Save);
  expect(await receiptLinePage.quantityValidationMessage.getText()).toEqual(data.validationMessage);
});

After({ tags: '@TEST_PD-27170' }, async () => {
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  expect(deleteSO.success).toEqual(true);
});
