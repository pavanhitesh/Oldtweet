/* eslint-disable class-methods-use-this */
import { Fields$OrderApi__Item__c } from 'packages/fonteva/fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { WebPage } from '../../../../globals/web/web.page';
import { conn } from '../../shared/helpers/force.helper';

// TODO: methods can be simplifies
class RapidOrderEntryPage extends WebPage {
  private itemPriceRuleConfigured!: string;

  private itemManageButton!: string;

  private itemRemoveButton!: string;

  private packagedItemPriceRule!: string;

  private instructionalText!: string;

  get addedItemsCardsSection() {
    return $(`//div[@class='ROEApiItemCard']/..`);
  }

  get subscriberContactText() {
    return $(
      `//div[@class='ROEApiItemCard']//div[@data-label="Subscriber"]//div[contains(@class,'selectize-input')]//div`,
    );
  }

  get salesOrderNumber() {
    return $(`//span[text()='Sales Order']/span`);
  }

  get clearSubscriberContact() {
    return $(`//div[@class='ROEApiItemCard']//div[@data-name="customerId"]/div//img[@alt="Clear Search"]`);
  }

  get subscriberContact() {
    return $(`//div[@class='ROEApiItemCard']//div[@data-label="Subscriber"]//input`);
  }

  get assignedContact() {
    const element = this.addedItemsCardsSection;
    return element.$$(`//tr[@class="ROEApiSubscriptionAssignmentRow"]/td[2]`);
  }

  get assign() {
    return $('//button[@data-label="Assign"]');
  }

  get assignContactInputBox() {
    return $('//div[@data-name="subscriberId"]//input');
  }

  get contactSelected() {
    return $(`//div[@data-name='contactIdValueCustomerLookup']//input/../div/span`);
  }

  get contactRemoveIcon() {
    return $(`//div[@data-name='contactIdValueCustomerLookup']//img[@alt='Clear Search']`);
  }

  get contactNameInputBox() {
    return $(`//div[@data-name='contactIdValueCustomerLookup']//input`);
  }

  get customerEntitySelected() {
    return $(`//div[@data-name='customerLookupIdValue']//input/../div/span`);
  }

  get customerEntityRemoveIcon() {
    return $(`//div[@data-name='customerLookupIdValue']//img[@alt='Clear Search']`);
  }

  get customerEntityInputBox() {
    return $(`//div[@data-name='customerLookupIdValue']//input`);
  }

  get addedOptionalItemName() {
    return $(
      `//div[contains(@class,'ROEApiPackageItemDetails') and not(contains(@class,'slds-hide'))]//table//tbody/tr/td[2]`,
    );
  }

  get addedItemCard() {
    return $(`//div[@class='ROEApiItemCard']`);
  }

  get optionalItemPriceText() {
    return $(
      `//div[contains(@class,'ROEApiPackageItemDetails') and not(contains(@class,'slds-hide'))]//table//span[@class='currencyInputSpan FrameworkCurrencyField']`,
    );
  }

  get optionalItemCheckBox() {
    return $(
      `//div[contains(@class,'ROEApiPackageItemDetails') and not(contains(@class,'slds-hide'))]//label[@data-name='selectItem']/span`,
    );
  }

  get itemQuickAddTextBox() {
    return $(`//div[@data-name='quickAddItem']//div[contains(@class,'selectize-input items')]/input`);
  }

  get addToOrderButton() {
    return $(`//button[@data-label='Add to Order']`);
  }

  get itemQtyTextBox() {
    return $(`//div[@data-name='itemQuickAdd']//div[@data-name='quantity']/input`);
  }

  get addedItems() {
    const element = this.addedItemsCardsSection;
    return element.$$(`//div[@class='ROEApiItemCard']//div[@data-name='itemCardLink']//div[2]/div[1]`);
  }

  get optionalPackageItemsCard() {
    return $(`//div[contains(@class,'ROEApiPackageItemDetails') and not(contains(@class,'slds-hide'))]`);
  }

  get optionalPackageItemQty() {
    return $(
      `//div[contains(@class,'ROEApiPackageItemDetails') and not(contains(@class,'slds-hide'))]//div[@data-name='quantity']/input`,
    );
  }

  get paymentTypeDropDown() {
    return $(`//select[@name='Payment Type']`);
  }

  get discountCode() {
    return $('[data-name="discountCode"] input');
  }

  get applyDiscountCode() {
    return $('//button[@data-name ="applyDiscountCode"]');
  }

  get itemQuickAdd() {
    return $('[data-name="quickAddItem"] input');
  }

  get addToOrder() {
    return $('button[data-name="addItemButton"]');
  }

  get go() {
    return $('button[data-name="processPaymentBtn"]');
  }

  get exit() {
    return $('button[data-name="exitBtn"]');
  }

  get advancedSettings() {
    return $('//button[text()="Advanced Settings"]');
  }

  get businessGroup() {
    return $('//select[@name="Business Group"]');
  }

  get saveAdvancedSettings() {
    return $('//button[@title="Save"]');
  }

  get cityNameTextBoxInForm() {
    return $(`//div[@class='ROEApiItemCard']//div[@data-label='Enter the city name']/input`);
  }

  get priceRule() {
    return $(`//div[contains(@class, 'ROEApiSubscriptionItemDetails')]//label[text()='Price Rule']/../div/strong`);
  }

  get subcriptionPlan() {
    return $('//select[@name="Select Plan"]');
  }

  get attachedFormElement() {
    return $(`//div[@data-aura-class="ROEApiForm"]/div`);
  }

  set itemPriceRule(itemName: string) {
    this.itemPriceRuleConfigured = `//div[text()="${itemName}"]/../../..//div[contains(@class, 'ROEApiSubscriptionItemDetails')]//label[text()='Price Rule']/../div/strong`;
  }

  get itemPriceRuleDisplayed() {
    return $(this.itemPriceRuleConfigured);
  }

  set itemNameManageButton(itemName: string) {
    this.itemManageButton = `//div[text()="${itemName}"]/../../div//button[contains(@class,"Button")]`;
  }

  set itemNameRemoveButton(itemName: string) {
    this.itemRemoveButton = `//div[text()="${itemName}"]/../..//ul/li/a[text()="Remove from Order"]`;
  }

  set packagedItemName(packagedItemName: string) {
    this.packagedItemPriceRule = `//div[contains(@class,'ROEApiPackageItemDetails')]//strong[text()="${packagedItemName}"]/../..//span[@class='currencyInputSpan FrameworkCurrencyField']/../self::strong`;
  }

  get itemAddedManageButton() {
    return $(this.itemManageButton);
  }

  get itemAddedRemoveButton() {
    return $(this.itemRemoveButton);
  }

  get packagedItemPriceRuleDisplayed() {
    return $(this.packagedItemPriceRule);
  }

  set skipLogicInstructionalText(value: string) {
    this.instructionalText = `//div[text()="${value}"]/../following-sibling::div[not(contains(@class,'hidden'))]/div`;
  }

  get skipLogicInstructionalTextDetails() {
    return $(this.instructionalText);
  }

  async changeContactForOrder(contactName: string) {
    await super.click(await this.contactRemoveIcon);
    await super.waitForEnable(await this.contactNameInputBox, MilliSeconds.XS);
    await super.slowTypeFlex(await this.contactNameInputBox, contactName);
    await super.sleep(MilliSeconds.XXS);
    await browser.keys(['Enter']);
    await super.waitForPresence(await this.contactRemoveIcon);
  }

  async changeCustomerEntityForOrder(entityName: string) {
    await super.click(await this.customerEntityRemoveIcon);
    await super.waitForEnable(await this.customerEntityInputBox, MilliSeconds.XS);
    await super.slowTypeFlex(await this.customerEntityInputBox, entityName);
    await super.sleep(MilliSeconds.XXS);
    await browser.keys(['Enter']);
    await super.waitForPresence(await this.customerEntityRemoveIcon);
  }

  async getSelectedContactForOrder() {
    return super.getText(await this.contactSelected);
  }

  async addItemToOrder(itemName: string, Qty = 1, subscriptionPlan?: string) {
    await super.click(await this.itemQuickAddTextBox, MilliSeconds.M);
    await super.sleep(MilliSeconds.XXS);
    await super.slowTypeFlex(await this.itemQuickAddTextBox, itemName);
    await super.sleep(MilliSeconds.XXS);
    await browser.keys(['Enter']);
    const { records } = await conn.query<Fields$OrderApi__Item__c>(
      `Select OrderApi__Is_Subscription__c from OrderApi__item__c where Name= '${itemName}'`,
    );
    await super.waitForPresence(await this.addToOrderButton, MilliSeconds.XL);
    if (records[0].OrderApi__Is_Subscription__c === false && Qty !== 1) {
      await super.type(await this.itemQtyTextBox, Qty);
    } else if (records[0].OrderApi__Is_Subscription__c === true) {
      if (subscriptionPlan !== undefined) {
        await this.selectByAttribute(await this.subcriptionPlan, 'label', subscriptionPlan as string);
        expect(await $(`//option[@label="${subscriptionPlan}"]`).isSelected()).toBe(true);
      }
    }
    await super.click(await this.addToOrderButton);
    await super.sleep(MilliSeconds.XXS);
    await super.waitForPresence(await this.addedItemCard, MilliSeconds.M);
    await super.waitForDisable(await this.addToOrderButton, MilliSeconds.XL);
  }

  async updateOptionalPackageItemQty(itemName: string, Qty: number) {
    await this.expandItemtoViewDetails(itemName);
    await super.waitForPresence(await this.optionalPackageItemsCard, MilliSeconds.S);
    await super.click(await this.optionalItemCheckBox);
    await super.waitForEnable(await this.optionalPackageItemQty);
    await super.type(await this.optionalPackageItemQty, Qty);
    await browser.keys(['Enter']);
    await super.waitForEnable(await this.go, MilliSeconds.XL);
  }

  async selectPaymentTypeAndProceedFurther(paymentType: string) {
    await super.scrollToElement(await this.paymentTypeDropDown);
    await super.selectByVisibleText(await this.paymentTypeDropDown, paymentType);
    await super.click(await this.go);
  }

  async getOptionalItemPrice() {
    return Number((await super.getText(await this.optionalItemPriceText)).replace('$', ''));
  }

  async getAddedItemNames() {
    const parentCards = this.addedItems;
    const itemNames: string[] = new Array(await parentCards.length);
    let index = 0;
    await parentCards.forEach(async (element) => {
      itemNames[index] = await super.getText(element);
      index += 1;
    });
    return itemNames;
  }

  async expandItemtoViewDetails(itemName: string) {
    (await Promise.all(await this.addedItems)).forEach(async (item) => {
      if ((await super.getText(item)) === itemName) {
        await super.click(item);
      }
    });
  }

  async verifyItemAddedToOrder(itemNameToCheck: string) {
    let itemAdded = false;
    await super.waitForPresence(await this.go);
    (await Promise.all(await this.getAddedItemNames())).forEach((itemName: string) => {
      if (itemName === itemNameToCheck) {
        itemAdded = true;
      }
    });
    return itemAdded;
  }

  async getAssignedContactNames() {
    const assignedContacts = this.assignedContact;
    const contactNames: string[] = new Array(await assignedContacts.length);
    let index = 0;
    await assignedContacts.reduce(async (memo, ele) => {
      await memo;
      contactNames[index] = await super.getText(ele);
      index += 1;
    });
    return contactNames;
  }

  async verifyAssignedContact(contactNameToCheck: string) {
    let contactAdded = false;
    await super.sleep(MilliSeconds.XS);
    (await Promise.all(await this.getAssignedContactNames())).forEach((contactName: string) => {
      if (contactName === contactNameToCheck) {
        contactAdded = true;
      }
    });
    return contactAdded;
  }

  async changeSubscriptionContact(contactName: string) {
    await super.click(await this.clearSubscriberContact);
    await super.click(await this.subscriberContact);
    await super.slowTypeFlex(await this.subscriberContact, contactName);
    await super.sleep(MilliSeconds.XXS);
    await browser.keys(['Enter']);
    expect(await super.getText(await this.subscriberContactText)).toEqual(contactName);
  }

  async removeItemFromOrder(itemName: string) {
    this.itemNameManageButton = itemName;
    this.itemNameRemoveButton = itemName;
    await super.mouseHoverOver(await this.itemAddedManageButton);
    await super.click(await this.itemAddedRemoveButton);
    await super.waitForAjaxCall();
    await super.waitForPresence(await this.go);
  }
}
export const rapidOrderEntryPage = new RapidOrderEntryPage();
