/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { commonPortalPage } from './common.page';
/**
 * sub page containing specific selectors and methods for a specific page
 */
class StorePage extends WebPage {
  get pageheader() {
    return $('[data-name="storeLabel"]');
  }

  get quantity() {
    return $('//select[@class="slds-select"]');
  }

  get addToOrderButton() {
    return $(`//button[@data-label="Add to Order"]`);
  }

  get subscriptionPlanSelect() {
    return $(`//div[@data-name="subscriptionPlanDropdown"]//select`);
  }

  get addToCartButton() {
    return $(`//div[@data-name="nextButton"]/button`);
  }

  async selectItemwithSubscriptionPlan(itemName: string, plan: string) {
    await super.waitForPresence(await commonPortalPage.buttonSearch);
    const searchbutton = await (await commonPortalPage.buttonSearch).shadow$('svg[data-key="search"]');
    await super.click(searchbutton);
    await super.type(await commonPortalPage.searchBar, itemName);
    await browser.keys('Enter');
    await super.click(await commonPortalPage.linkstoreItem);
    await super.waitForPresence(await this.addToOrderButton);
    await super.selectByVisibleText(await this.subscriptionPlanSelect, plan);
  }
}

export const storePage = new StorePage();
