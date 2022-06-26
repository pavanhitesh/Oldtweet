/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

class SalesOrderLinePage extends WebPage {
  private itemLink!: string;

  get newButton() {
    return $(`//a[@title="New"]`);
  }

  get salesOrderLinePageHeader() {
    return $(`//h1/div[contains(@class,'entityNameTitle') and text()='Sales Order Line']`);
  }

  get editDeferredRevenue() {
    return $('//button[@title="Edit Deferred Revenue Adjustment"]');
  }

  get editShippingTrackingNumber() {
    return $('//button[@title="Edit Shipping Tracking Number"]');
  }

  get shippingTrackingNumberInput() {
    return $('//input[@name="OrderApi__Shipping_Tracking_Number__c"]');
  }

  get editItemName() {
    return $('//button[@title="Edit Item"]');
  }

  get clearSelection() {
    return $('(//button[@title="Clear Selection"])[3]');
  }

  get editItemTextBox() {
    return $('//input[contains(@placeholder,"Search Items")]');
  }

  get itemClassTextBox() {
    return $(`//input[contains(@placeholder,"Search Item Classes")]`);
  }

  get bussinessGroup() {
    return $(`//input[contains(@placeholder,"Search Business Groups")]`);
  }

  get isSubscriptionCheckbox() {
    return $(`//input[@name="OrderApi__Is_Subscription__c"]`);
  }

  get priceRuleTextBox() {
    return $(`//input[contains(@placeholder,"Search Price Rules")]`);
  }

  get subscriptionPlanTextBox() {
    return $(`//input[contains(@placeholder,"Search Subscription Plans")]`);
  }

  get subscriptionStartDate() {
    return $(`//input[@name="OrderApi__Subscription_Start_Date__c"]`);
  }

  get activationDate() {
    return $('//input[@name="OrderApi__Activation_Date__c"]');
  }

  set itemNameLink(itemName: string) {
    this.itemLink = `//a[@title="${itemName}"]`;
  }

  get itemNameClassLink() {
    return $(this.itemLink);
  }

  get saveEdit() {
    return $('//button[@name="SaveEdit"]');
  }

  get edit() {
    return $('//button[@name="Edit"]');
  }

  async createSubscriptionSalesItem(
    itemClass: string,
    itemName: string,
    businessGroup: string,
    priceRule: string,
    subscriptionPlan: string,
    subscriptionStartDate: string,
    activationDate: string,
  ) {
    await this.enterSalesOrderLineItemData(await this.itemClassTextBox, itemClass);
    await this.enterSalesOrderLineItemData(await this.editItemTextBox, itemName);
    await this.enterSalesOrderLineItemData(await this.bussinessGroup, businessGroup);
    await this.enterSalesOrderLineItemData(await this.priceRuleTextBox, priceRule);
    await this.enterSalesOrderLineItemData(await this.subscriptionPlanTextBox, subscriptionPlan);
    await super.type(await this.subscriptionStartDate, subscriptionStartDate);
    await super.type(await this.activationDate, activationDate);
    await super.sleep(MilliSeconds.XXXS);
    await super.click(await this.saveEdit);
  }

  async enterSalesOrderLineItemData(element: WebdriverIO.Element, data: string) {
    await super.slowTypeFlex(element, data);
    await super.sleep(MilliSeconds.XXS);
    await browser.keys(['Enter']);
    this.itemNameLink = data;
    await super.click(await this.itemNameClassLink);
    await super.sleep(MilliSeconds.XXXS);
  }
}

export const salesOrderLinePage = new SalesOrderLinePage();
