import { Before, Then, After } from '@cucumber/cucumber';
import * as faker from 'faker';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$PagesApi__Field_Response__c,
  Fields$PagesApi__Form_Response__c,
  Fields$OrderApi__Receipt__c,
} from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { itemFormPage } from '../../pages/portal/item-form.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';
import { subscriptionToRenewPage } from '../../pages/portal/subscriptions-to-renew.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';

let salesOrder: string[] = [];

Before({ tags: '@TEST_PD-28405' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28405' }, async () => {
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(salesOrder[1]);
  expect(deleteSO.success).toEqual(true);
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy((await browser.sharedStore.get('subscriptionId')) as string);
  expect(deleteSubscription.success).toEqual(true);
  const originalSO = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
        'receiptNameROE',
      )}'`,
    )
  ).records[0].OrderApi__Sales_Order__c;
  const deleteOriginalSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(originalSO as string);
  expect(deleteOriginalSO.success).toEqual(true);
});

Then('User enters the form response and navigate to shopping cart page', async () => {
  const formInput = faker.random.word();
  await itemFormPage.slowTypeFlex(await itemFormPage.enterTheCityName, formInput);
  await itemFormPage.click(await itemFormPage.addToCart);
  await shoppingCartPage.waitForClickable(await shoppingCartPage.itemEdit);
  salesOrder = (await browser.getUrl()).split('cart/');
  const formResponseId = (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id FROM PagesApi__Form_Response__c WHERE OrderApi__Sales_Order_Line__c IN (SELECT Id FROM  OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrder[1]}')`,
    )
  ).records[0].Id;
  const formFieldResponse = (
    await conn.query<Fields$PagesApi__Field_Response__c>(
      `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}'`,
    )
  ).records[0].PagesApi__Response__c;
  expect(formFieldResponse).toEqual(formInput);
});

Then(
  'User updates the renewal item {string} and verifies the form response is deleted',
  async (renewalItem: string) => {
    await shoppingCartPage.click(await shoppingCartPage.itemEdit);
    await subscriptionToRenewPage.click(await subscriptionToRenewPage.change);
    await subscriptionToRenewPage.click(
      await $(`//div[text() = '${renewalItem}'] /parent::div /parent::div /parent::div //button`),
    );
    await subscriptionToRenewPage.waitForClickable(await subscriptionToRenewPage.change);
    await assignMemberPage.click(await assignMemberPage.AddToCart);
    await shoppingCartPage.waitForClickable(await shoppingCartPage.cartCheckout);
    const formResponseRecords = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id FROM PagesApi__Form_Response__c WHERE OrderApi__Sales_Order_Line__c IN (SELECT Id FROM  OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${salesOrder[1]}')`,
      )
    ).records;
    expect(formResponseRecords.length).toEqual(0);
  },
);
