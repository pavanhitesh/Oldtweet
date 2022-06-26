import { Given, Then, Before } from '@cucumber/cucumber';
import {
  Fields$OrderApi__Receipt__c,
  Fields$OrderApi__Sales_Order_Line__c,
  Fields$PagesApi__Form_Response__c,
} from 'packages/fonteva/fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { loginPage } from '../../pages/salesforce/login.page';

Before({ tags: '@TEST_PD-28356' }, async () => {
  await loginPage.open('/');
  if (await loginPage.isDisplayed(await loginPage.username)) {
    await loginPage.login();
  }
});

Given(
  'User is able to expand the item {string} and fill the city name {string} in the Form',
  async (itemName: string, cityName: string) => {
    await rapidOrderEntryPage.expandItemtoViewDetails(itemName);
    await rapidOrderEntryPage.slowTypeFlex(await rapidOrderEntryPage.cityNameTextBoxInForm, cityName);
    expect(await rapidOrderEntryPage.isDisplayed(await rapidOrderEntryPage.go)).toEqual(true);
  },
);

Then(
  'User verifies the Form Responses will have details like Contact, Account, Entity, Item, Sales Order and SalesOrderLine',
  async () => {
    const salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(`SELECT OrderApi__Sales_Order__c
  FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get('receiptNameROE')}'`)
    ).records[0].OrderApi__Sales_Order__c;

    const salesOrderLineId = (
      await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
        `SELECT Id FROM OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__c = '${salesOrderId}'`,
      )
    ).records[0].Id;

    const formResponse = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT PagesApi__Account__c, PagesApi__Contact__c, PagesApi__Entity__c, OrderApi__Item__c, OrderApi__Sales_Order_Line__c FROM PagesApi__Form_Response__c WHERE OrderApi__Sales_Order__c  = '${salesOrderId}'`,
      )
    ).records[0];
    expect(formResponse.PagesApi__Contact__c).toEqual(await browser.sharedStore.get('contactId'));
    expect(formResponse.PagesApi__Account__c).toEqual(await browser.sharedStore.get('accountId'));
    expect(formResponse.PagesApi__Entity__c).toEqual('Contact');
    expect(formResponse.OrderApi__Item__c).toEqual(await browser.sharedStore.get('itemId'));
    expect(formResponse.OrderApi__Sales_Order_Line__c).toEqual(salesOrderLineId);
  },
);
