import { Before, Given, Then } from '@cucumber/cucumber';
import { Fields$EventApi__Ticket_Type__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { itemPriceRulesListPage } from '../../pages/salesforce/item-price-rule-list.page';
import { priceRulePage } from '../../pages/salesforce/price-rule.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

Before({ tags: '@TEST_PD-28351' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(`User opens the PriceRules list page for a ticket of Event {string}`, async (eventName: string) => {
  const ticketId = (
    await conn.query<Fields$EventApi__Ticket_Type__c>(`SELECT Id FROM EventApi__Ticket_Type__c WHERE EventApi__Is_Active__c = true AND EventApi__Is_Published__c = true AND EventApi__Quantity_Remaining__c !=0 AND EventApi__Event__c IN (SELECT Id FROM EventApi__Event__c WHERE Name = '${eventName}')
`)
  ).records[0].Id;

  await itemPriceRulesListPage.open(
    `/lightning/r/EventApi__Ticket_Type__c/${ticketId}/related/EventApi__Price_Rules__r/view`,
  );
  await itemPriceRulesListPage.waitForClickable(await itemPriceRulesListPage.newPriceRuleButton);
  expect(await itemPriceRulesListPage.isDisplayed(await itemPriceRulesListPage.newPriceRuleButton)).toBe(true);
});

Then(`User clicks on New Price Rule Button and verifies Price Rule page is dispalyed`, async () => {
  await itemPriceRulesListPage.click(await itemPriceRulesListPage.newPriceRuleButton);
  const priceRuleFrame = await (await $('div[class="oneAlohaPage"]')).shadow$('iframe[title="accessibility title"]');
  await priceRulePage.switchToFrame(priceRuleFrame);
  await priceRulePage.waitForPresence(await priceRulePage.cancel, MilliSeconds.L);
  expect(await priceRulePage.isDisplayed(await priceRulePage.cancel)).toBe(true);
});
