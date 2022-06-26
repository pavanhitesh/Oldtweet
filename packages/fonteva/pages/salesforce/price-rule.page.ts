/* eslint-disable class-methods-use-this */
import { Fields$OrderApi__Price_Rule__c } from 'packages/fonteva/fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { WebPage } from '../../../../globals/web/web.page';
import { conn } from '../../shared/helpers/force.helper';

class PriceRulePage extends WebPage {
  #dateInCalendar = `//table[@class='calGrid']//tbody//td[contains(@class,'uiDayInMonthCell') and not (contains(@class,'disabled'))]/span[text()='{datevalue}']`;

  get saveDownArrow() {
    return $('//button[@id="savePriceRules"]/ancestor::div[1]/span');
  }

  get saveAndNew() {
    return $('//a[text()= "Save & New"]');
  }

  get newPriceRuleTab() {
    return $('//li[@data-id="FON_PR_Create"]');
  }

  get name() {
    return $('//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[@data-name="name"]//input');
  }

  get addRule() {
    return $('//div[contains(@class,"active in OrderApiPriceRuleDetail")]//button[text()= "Add Rule"]');
  }

  get ruleCriteriaFirstRow() {
    return $(
      '//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[contains(text(),"Create additional rules")]/following::span/div[1]',
    );
  }

  get ruleCriteriaSecondRow() {
    return $(
      '//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[contains(text(),"Create additional rules")]/following::span/div[2]',
    );
  }

  get ruleObject() {
    return $('//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[@data-name="objectName"]//select');
  }

  get ruleField() {
    return $('//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[@data-name="field"]//select');
  }

  get ruleOperator() {
    return $('//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[@data-name="operator"]//select');
  }

  get ruleValue() {
    return $('//div[contains(@class,"active in OrderApiPriceRuleDetail")]//div[@data-name="value"]//select');
  }

  get priceRuleStartDate() {
    return $(`//div[contains(@class,'active in OrderApiPriceRuleDetail')]//div[@data-name='startDate']//input`);
  }

  get priceRuleEndDate() {
    return $(`//div[contains(@class,'active in OrderApiPriceRuleDetail')]//div[@data-name='endDate']//input`);
  }

  get monthNameInCalendar() {
    return $(`//h2[@class='monthYear']`);
  }

  get nextMonthIconInCalendar() {
    return $(`//a[@title='Go to next month']`);
  }

  get yearSelectionInCalendar() {
    return $(`//span[text()= 'Pick a Year']/following::select`);
  }

  get cancel() {
    return $(`//button[@data-name='cancelPriceRules']`);
  }

  get priceRuleStartDateCalendarIcon() {
    return $(`//div[@data-name='startDate']//a[contains(@class,'datePicker-openIcon')]`);
  }

  get priceRuleEndDateCalendarIcon() {
    return $(`//div[@data-name='endDate']//a[contains(@class,'datePicker-openIcon')]`);
  }

  get save() {
    return $(`#savePriceRules`);
  }

  async getdateInCalendar(dateValue: string) {
    return $(this.#dateInCalendar.replace('{datevalue}', dateValue));
  }

  async openPriceRulePage(priceRuleId: string) {
    await super.open(`/lightning/r/OrderApi__Price_Rule__c/${priceRuleId}/view`);
    await super.sleep(MilliSeconds.XXS);
    await super.waitForAjaxCall();
    const priceRuleFrame = await (await $('div[class="oneAlohaPage"]')).shadow$('iframe[title="accessibility title"]');
    await super.switchToFrame(priceRuleFrame);
    await super.waitForPresence(await this.cancel);
  }

  async deletePriceRule(ruleName: string) {
    const result = await conn.query<Fields$OrderApi__Price_Rule__c>(
      `SELECT Id FROM OrderApi__Price_Rule__c WHERE Name = '${ruleName}'`,
    );
    const priceRuleId = result.records.map((item) => item.Id);
    await conn.destroy('OrderApi__Price_Rule__c', priceRuleId);
  }

  async selectDateUsingCalendar(month: string, date: string, year: string) {
    // Selecting Month
    await this.selectMonth(month);

    // Selecting Year
    await super.click(await this.yearSelectionInCalendar);
    await super.selectByAttribute(await this.yearSelectionInCalendar, 'value', year);

    // Select Date
    await super.click(await this.getdateInCalendar(date));
  }

  // Helper
  async selectMonth(monthName: string) {
    let calMonthName = await super.getText(await this.monthNameInCalendar);
    while (calMonthName !== monthName) {
      await super.click(await this.nextMonthIconInCalendar);
      await super.sleep(MilliSeconds.XXXS);
      calMonthName = await super.getText(await this.monthNameInCalendar);
    }
  }
}
export const priceRulePage = new PriceRulePage();
