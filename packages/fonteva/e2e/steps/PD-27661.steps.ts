import { Before, After, When, Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Price_Rule_Variable__c } from 'packages/fonteva/fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { priceRulePage } from '../../pages/salesforce/price-rule.page';

const priceRule: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-27880' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27880' }, async () => {
  await priceRulePage.deletePriceRule(priceRule.Name);
});

When('User creates new price rule {string}', async (ruleName: string) => {
  await priceRulePage.click(await priceRulePage.saveDownArrow);
  await priceRulePage.click(await priceRulePage.saveAndNew);
  await priceRulePage.waitForPresence(await priceRulePage.newPriceRuleTab);
  await priceRulePage.type(await priceRulePage.name, ruleName);
  expect(await priceRulePage.name.getValue()).not.toBe('');
});

Then(
  'User saves price rule criteria with {string} {string} {string} {string} and verifies {string}',
  async (object: string, field: string, operator: string, value: string, ruleName: string) => {
    // creation of price rule criteria
    await priceRulePage.scrollToElement(await priceRulePage.addRule);
    await priceRulePage.click(await priceRulePage.addRule);
    await priceRulePage.selectByAttribute(await priceRulePage.ruleObject, 'value', object);
    await priceRulePage.selectByAttribute(await priceRulePage.ruleField, 'value', field);
    await priceRulePage.selectByAttribute(await priceRulePage.ruleOperator, 'value', operator);
    await priceRulePage.selectByAttribute(await priceRulePage.ruleValue, 'value', value);
    await priceRulePage.click(await priceRulePage.save);
    await priceRulePage.waitForAjaxCall();
    priceRule.Name = ruleName as string;

    // Backend validation of price rule criteria
    const { records } = await conn.query<Fields$OrderApi__Price_Rule_Variable__c>(
      `SELECT Id, OrderApi__Field__c, OrderApi__Object__c, OrderApi__Operator__c, OrderApi__Value__c FROM 
    OrderApi__Price_Rule_Variable__c where OrderApi__Price_Rule__r.Name = '${ruleName}'`,
    );
    expect(records.length).toEqual(1);
    expect(records[0].OrderApi__Object__c).toEqual(object);
    expect(records[0].OrderApi__Field__c).toEqual(field);
    expect(records[0].OrderApi__Operator__c).toEqual(operator);
    expect(records[0].OrderApi__Value__c).toEqual(value);

    // UI validation of price rule criteria
    await priceRulePage.scrollToElement(await priceRulePage.ruleCriteriaFirstRow);
    expect(await priceRulePage.isDisplayed(await priceRulePage.ruleCriteriaFirstRow)).toEqual(true);
    expect(await priceRulePage.ruleCriteriaSecondRow.isExisting()).toEqual(false);
  },
);
