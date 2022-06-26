import { Before, Then, DataTable, After } from '@cucumber/cucumber';
import * as faker from 'faker';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$PagesApi__Form_Response__c,
  Fields$PagesApi__Field_Response__c,
  Fields$OrderApi__Assignment__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Receipt__c,
} from '../../fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { loginPage } from '../../pages/salesforce/login.page';
import { itemRenewalFormPage } from '../../pages/portal/item-renewal-form.page';
import { subscriptionToRenewPage } from '../../pages/portal/subscriptions-to-renew.page';
import { itemFormPage } from '../../pages/portal/item-form.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';
import { additionalItemsPage } from '../../pages/portal/additional-items.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';
import * as data from '../data/PD-9864.json';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28951' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28951' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId);
  expect(deleteSubscription.success).toEqual(true);
  const deleteRenewalSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteRenewalSO.success).toEqual(true);
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

Then('User should be able to enter the renewal form response', async () => {
  state.renewalFormInput = faker.random.word();
  await itemRenewalFormPage.slowTypeFlex(await itemRenewalFormPage.rating, state.renewalFormInput);
  await itemRenewalFormPage.click(await itemRenewalFormPage.continue);
  await itemRenewalFormPage.waitForClickable(await itemRenewalFormPage.change);
  expect(await itemRenewalFormPage.continue.isDisplayed()).toBe(false);
});

Then('User should be able to enter the form response and navigate to shopping cart page', async () => {
  state.formInput = faker.random.word();
  await itemFormPage.waitForClickable(await itemFormPage.addToCart);
  await itemFormPage.slowTypeFlex(await itemFormPage.VenueFeedback, state.formInput);
  await itemFormPage.click(await itemFormPage.addToCart);
  await shoppingCartPage.waitForClickable(await shoppingCartPage.cartCheckout);
  expect(await shoppingCartPage.header.isDisplayed()).toBe(true);
});

Then(
  'User updates the form responses, assign members and additional item {string} for {string} item',
  async (additionalItem: string, renewalItem: string, members: DataTable) => {
    await shoppingCartPage.click(await shoppingCartPage.itemEdit);
    await itemRenewalFormPage.waitForClickable(await itemRenewalFormPage.change);
    await itemRenewalFormPage.waitForAjaxCall();
    await itemRenewalFormPage.click(await itemRenewalFormPage.change);
    await itemRenewalFormPage.waitForClickable(await itemRenewalFormPage.continue);
    expect(await browser.execute(`return arguments[0].value`, await itemRenewalFormPage.rating)).toEqual(
      state.renewalFormInput,
    );
    state.updatedRenewalFormInput = faker.random.word();
    await itemRenewalFormPage.slowTypeFlex(await itemRenewalFormPage.rating, state.updatedRenewalFormInput);
    await itemRenewalFormPage.click(await itemRenewalFormPage.continue);
    await itemRenewalFormPage.waitForClickable(await itemRenewalFormPage.change);
    subscriptionToRenewPage.subscriptionToRenew = renewalItem;
    await subscriptionToRenewPage.click(await subscriptionToRenewPage.renewSubscription);
    await additionalItemsPage.click(await additionalItemsPage.change);
    await additionalItemsPage.waitForClickable(await additionalItemsPage.continue);
    additionalItemsPage.singleAdditionalItem = additionalItem;
    await additionalItemsPage.click(await additionalItemsPage.selectAdditionalItem);
    await additionalItemsPage.click(await additionalItemsPage.continue);
    await assignMemberPage.click(await assignMemberPage.change);
    await assignMemberPage.waitForClickable(await assignMemberPage.searchMember);
    const orderData = members.hashes();
    await orderData.reduce(async (memo, member) => {
      await memo;
      await assignMemberPage.slowTypeFlex(await assignMemberPage.searchMember, member.name);
      await assignMemberPage.selectAssignMember(member.name);
    }, undefined);
    await assignMemberPage.click(await assignMemberPage.AddToCart);
    await itemFormPage.waitForClickable(await itemFormPage.addToCart);
    expect(await browser.execute(`return arguments[0].value`, await itemFormPage.VenueFeedback)).toEqual(
      state.formInput,
    );
    state.updatedFormInput = faker.random.word();
    await itemFormPage.slowTypeFlex(await itemFormPage.VenueFeedback, state.updatedFormInput);
    await itemFormPage.click(await itemFormPage.addToCart);
    await shoppingCartPage.waitForClickable(await shoppingCartPage.cartCheckout);
    expect(await shoppingCartPage.header.isDisplayed()).toBe(true);
  },
);

Then(
  'User verifies the renewal form, item form responses and the assignments selected on the backend',
  async (members: DataTable) => {
    await loginPage.sleep(MilliSeconds.XS);
    const renewalFormResponseId = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id FROM PagesApi__Form_Response__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'portalSO',
        )}' AND PagesApi__Form__r.Name = '${data.itemRenewalForm}'`,
      )
    ).records[0].Id;
    const renewalFormFieldResponse = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${renewalFormResponseId}' 
      AND PagesApi__Field__r.Name = '${data.renewalFormField}'`,
      )
    ).records[0].PagesApi__Response__c;
    expect(renewalFormFieldResponse).toEqual(state.updatedRenewalFormInput);
    const formResponseId = (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id FROM PagesApi__Form_Response__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'portalSO',
        )}' AND PagesApi__Form__r.Name = '${data.itemForm}'`,
      )
    ).records[0].Id;
    const formFieldResponse = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${formResponseId}' 
      AND PagesApi__Field__r.Name = '${data.formField}'`,
      )
    ).records[0].PagesApi__Response__c;
    expect(formFieldResponse).toEqual(state.updatedFormInput);
    const term = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT Id, OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'portalSO',
        )}'`,
      )
    ).records[0];
    state.subscriptionId = term.OrderApi__Subscription__c;
    const totalAssignments = (
      await conn.query<Fields$OrderApi__Assignment__c>(
        `SELECT OrderApi__Is_Active__c FROM OrderApi__Assignment__c WHERE OrderApi__Term__c = '${term.Id}'`,
      )
    ).records;
    expect(totalAssignments.length).toEqual(3);
    const orderData = members.hashes();
    await orderData.reduce(async (memo, member) => {
      await memo;
      const assignmentIsActive = (
        await conn.query<Fields$OrderApi__Assignment__c>(
          `SELECT OrderApi__Is_Active__c FROM OrderApi__Assignment__c WHERE OrderApi__Term__c = '${term.Id}' AND OrderApi__Full_Name__c = '${member.name}'`,
        )
      ).records[0].OrderApi__Is_Active__c;
      expect(assignmentIsActive).toEqual(false);
    }, undefined);
  },
);
