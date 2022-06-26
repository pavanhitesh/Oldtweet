import { After, Given, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { Fields$OrderApi__Store__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { portalSelfRegisterPage } from '../../pages/portal/self-register.page';

const state: { [key: string]: string | boolean } = {};

After({ tags: '@TEST_PD-28369' }, async () => {
  const apexBody = `OrderApi__Store__c contactMatchRule = [Select Id from OrderApi__Store__c Where Name = '${state.store}'];
    contactMatchRule.OrderApi__Contact_Match_Rule__c ='${state.oldMatchRule}';
    contactMatchRule.OrderApi__Contact_Match_Custom_Field__c ='${state.oldMatchField}';
    contactMatchRule.OrderApi__Require_Contact_Match_Custom_Field__c =${state.oldIsRequired};
    contactMatchRule.OrderApi__Default_Checkout__c ='${state.oldDefaultCheckout}';
    update contactMatchRule;`;
  await conn.tooling.executeAnonymous(apexBody);
});

Given(
  'User should update the contact match rule as {string} {string} {string} {string} in {string} store',
  async (matchRule: string, matchField: string, isRequired: string, backup: string, store: string) => {
    if (backup === 'true') {
      const oldMatchRuleData = (
        await conn.query<Fields$OrderApi__Store__c>(
          `SELECT OrderApi__Contact_Match_Rule__c, OrderApi__Contact_Match_Custom_Field__c, OrderApi__Require_Contact_Match_Custom_Field__c, OrderApi__Default_Checkout__c FROM OrderApi__Store__c WHERE Name = '${store}'`,
        )
      ).records;
      state.store = store;
      state.oldMatchRule = oldMatchRuleData[0].OrderApi__Contact_Match_Rule__c as string;
      state.oldMatchField = '';
      if (oldMatchRuleData[0].OrderApi__Contact_Match_Custom_Field__c)
        state.oldMatchField = oldMatchRuleData[0].OrderApi__Contact_Match_Custom_Field__c as string;
      state.oldIsRequired = oldMatchRuleData[0].OrderApi__Require_Contact_Match_Custom_Field__c as boolean;
      state.oldDefaultCheckout = oldMatchRuleData[0].OrderApi__Default_Checkout__c as string;
    }

    const apexBody = `OrderApi__Store__c contactMatchRule = [Select Id from OrderApi__Store__c Where Name = '${store}'];
      contactMatchRule.OrderApi__Contact_Match_Rule__c ='${matchRule}';
      contactMatchRule.OrderApi__Contact_Match_Custom_Field__c ='${matchField}';
      contactMatchRule.OrderApi__Require_Contact_Match_Custom_Field__c =${isRequired};
      contactMatchRule.OrderApi__Default_Checkout__c = 'Account Login';
      update contactMatchRule;`;
    await conn.tooling.executeAnonymous(apexBody);
  },
);

Then(
  'User should fill required fields and {string} and verify button is {string}',
  async (matchRuleField: string, clickable: string) => {
    await portalSelfRegisterPage.type(await portalSelfRegisterPage.firstName, faker.name.firstName());
    await portalSelfRegisterPage.type(await portalSelfRegisterPage.lastName, faker.name.lastName());
    await portalSelfRegisterPage.type(await portalSelfRegisterPage.email, faker.internet.email());
    await portalSelfRegisterPage.type(await portalSelfRegisterPage.userName, faker.internet.email());
    await portalSelfRegisterPage.type(await portalSelfRegisterPage.password, faker.internet.password());
    expect(
      await portalSelfRegisterPage.isDisplayed(await $(`//label[text()="${matchRuleField}"]//following::input`)),
    ).toBe(true);
    if (clickable === 'true') {
      expect(await portalSelfRegisterPage.createAccount.isClickable()).toBe(true);
    } else {
      expect(await portalSelfRegisterPage.createAccount.isClickable()).toBe(false);
      await portalSelfRegisterPage.type(await $(`//label[text()="${matchRuleField}"]//following::input`), 'test');
      await portalSelfRegisterPage.waitForEnable(await portalSelfRegisterPage.createAccount);
      expect(await portalSelfRegisterPage.createAccount.isClickable()).toBe(true);
    }
  },
);
