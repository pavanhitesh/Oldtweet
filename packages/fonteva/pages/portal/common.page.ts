/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { portalLoginPage } from './login.page';

class CommonPage extends WebPage {
  get companyOrdersHeader() {
    return $(`//h1[text()= 'Company Orders']`);
  }

  get companyOrders() {
    return $(`div[role="tablist"] a[title="Company Orders"]`);
  }

  get linkOrders() {
    return $('div[role="tablist"] a[title="Orders"]');
  }

  get orderContainer() {
    return $('.siteforceStarterBody');
  }

  get linkEventBooths() {
    return $('a[title="Event Booths"]');
  }

  get linkMemberships() {
    return $('a[title="Memberships"]');
  }

  get linkYodaMerch() {
    return $('a[title="YODA Merch"]');
  }

  get linkDonations() {
    return $('a[title="Donations"]');
  }

  get linkSponsorships() {
    return $('a[title="Sponsorships"]');
  }

  get linkPublications() {
    return $('a[title="Publications"]');
  }

  get selecetedOptionInMultiPicker() {
    return $('//div[@class="item"]');
  }

  get continueAsGuestLabel() {
    return $('//div[text()="Continue as Guest"]');
  }

  get checkoutPageLabel() {
    return $('[data-id="subHeaderTitle"]');
  }

  get picklistOptions() {
    return $('//div[@data-name="Multi_Select_Picklist__c"]//div[@class="option"]');
  }

  get guestRegistrationButton() {
    return $('//button[@data-name="guestRegistrationButton"]');
  }

  get multiSelectPickList() {
    return $('//div[@data-name="Multi_Select_Picklist__c"]//div[@data-name="Multi_Select_Picklist__c-input"]');
  }

  get email() {
    return $('//div[@data-name="Email"]//div[@data-name="matchFields"]//input');
  }

  get lastName() {
    return $('//div[@data-name="LastName"]//div[@data-name="matchFields"]//input');
  }

  get firstName() {
    return $('//div[@data-name="FirstName"]//div[@data-name="matchFields"]//input');
  }

  get continueAsGuest() {
    return $('//div[@id="content"]//button[contains(., "Continue as Guest here")]');
  }

  get cartButton() {
    return $('//div[contains(@class,"cart")][1]');
  }

  get checkoutButton() {
    return $('button[data-name="checkoutButton"]');
  }

  get viewCartButton() {
    return $('button[data-name="viewCartButton"]');
  }

  get textStoreLabel() {
    return $('[data-name="storeLabel"]');
  }

  get valueDiscountApplied() {
    return $('//div[normalize-space()="Discount Applied"]');
  }

  get processButton() {
    return $('//button[@aria-label="Process Payment"]');
  }

  get linkstoreItem() {
    return $('div.pfm-label');
  }

  get textBoxSourceCode() {
    return $('div[data-name="sourceCodeName"] input');
  }

  get buttonApplySourceCode() {
    return $('button[data-name="discountButton"]');
  }

  get userLogoButton() {
    return $('//button[contains(.,"Profile Menu")]');
  }

  get logout() {
    return $('//a[@role="menuitem" and text()="Logout"]');
  }

  get linkStore() {
    return $('a[title="Store"]');
  }

  get linkEvents() {
    return $('a[title="Events"]');
  }

  get buttonSearch() {
    return $('div.pfm-search_container');
  }

  get searchBar() {
    return $('#searchStoreInput');
  }

  get buttonAddtoCart() {
    return $('button[data-name="addToCart"]');
  }

  get imageCheckout() {
    return $('div.LTEShoppingCartIcon');
  }

  get buttonCheckout() {
    return $('button[data-name="checkoutButton"]');
  }

  get elXButton() {
    return $('//button[@aria-label="Close"]');
  }

  get buttonAddtoCartFromItemDetails() {
    return $('//button[text()="Add to Cart"]');
  }

  get itemQuantityInCheckout() {
    return $('//div[contains(text(),"Quantity")]');
  }

  get buttonSpinner() {
    return $('//img[@class="button-image"]');
  }

  get linkDescription() {
    return $('//div[@id="listing_results"]//a');
  }

  get additionalItems() {
    return $('//div[text()="Additional Items"]');
  }

  get continue() {
    return $('//button[@aria-label="Continue"]');
  }

  get addtoCartFromAdditionalItems() {
    return $('//button[@aria-label="Add to Cart"]');
  }

  get selectMailingState() {
    return $('//select[@name="MailingState"]');
  }

  get selectMailingCountry() {
    return $('//select[@name="MailingCountry"]');
  }

  get shoppingCartTitle() {
    return $('//div[@data-aura-class="LTEShoppingCart"]//div[text()="Shopping Cart"]');
  }

  get addedItems() {
    const element = $(`//div[contains(@class,'LTEShoppingCart')]/..`);
    return element.$$(`//div[contains(@class,'LTEShoppingCart')]//div[2]/div/div[2]/div[1]`);
  }

  async openOrderLinks() {
    await super.click(await this.linkOrders);
    await super.waitForPresence(await this.orderContainer);
  }

  async openCompanyOrders() {
    await super.click(await this.companyOrders);
    await super.waitForPresence(await this.companyOrdersHeader);
  }

  async selectItem(itemName: string) {
    await super.waitForPresence(await this.buttonSearch);
    const searchbutton = await (await this.buttonSearch).shadow$('svg[data-key="search"]');
    await super.click(searchbutton);
    await super.type(await this.searchBar, itemName);
    await browser.keys('Enter');
    await super.click(await this.linkstoreItem);
    await super.waitForPresence(await this.buttonAddtoCart);
  }

  async getStoreLabelText() {
    await super.waitForPresence(await this.textStoreLabel);
    return super.getText(await this.textStoreLabel);
  }

  async clickStore() {
    await super.click(await this.linkStore);
  }

  async addToCart() {
    await super.click(await this.buttonAddtoCart);
    await super.waitForPresence(await this.elXButton);
  }

  async clickOnAddToCartButton() {
    await super.click(await this.buttonAddtoCart);
  }

  async clickCheckoutbutton() {
    await super.waitForPresence(await this.imageCheckout);
    const buttonShoppingCart = await (await this.imageCheckout).shadow$('button.pfm-shopping-cart');
    await super.click(buttonShoppingCart);
    await super.click(await this.buttonCheckout);
    await super.waitForPresence(await this.textBoxSourceCode);
  }

  async clickViewCartbutton() {
    await super.waitForPresence(await this.imageCheckout);
    const buttonShoppingCart = await (await this.imageCheckout).shadow$('button.pfm-shopping-cart');
    await super.click(buttonShoppingCart);
    await super.click(await this.viewCartButton);
    await super.waitForPresence(await this.buttonCheckout);
  }

  async setDiscountCode(discountCode: string) {
    await super.waitForPresence(await this.textBoxSourceCode);
    await super.type(await this.textBoxSourceCode, discountCode);
    await browser.keys('Tab');
    await super.click(await this.buttonApplySourceCode);
    await super.waitForPresence(await this.valueDiscountApplied);
  }

  async open(path: string) {
    return super.open(`${path}/store`);
  }

  async getItemsInShoppingCart() {
    const parentCards = this.addedItems;
    const itemNames: string[] = new Array(await parentCards.length);
    let index = 0;
    await parentCards.forEach(async (element) => {
      itemNames[index] = await super.getText(element);
      index += 1;
    });
    return itemNames;
  }

  async logoutPortal() {
    await super.click(await this.userLogoButton);
    await super.click(await this.logout);
    await super.waitForPresence(await portalLoginPage.username);
  }

  async selectEvent(eventName: string) {
    await super.waitForPresence(await this.buttonSearch);
    const searchbutton = await (await this.buttonSearch).shadow$('svg[data-key="search"]');
    await super.click(searchbutton);
    await super.type(await this.searchBar, eventName);
    await browser.keys('Enter');
  }
}

export const commonPortalPage = new CommonPage();
