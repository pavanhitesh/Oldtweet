/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class AdvanceItemSettingPage extends WebPage {
  get continue() {
    return $('//button[@data-name="additionalNextBtn"]');
  }

  get addIncludedItem() {
    return $('//div[@class="FDServiceBuilderIncludedItems"]//button[@data-name="addItemBtn"]');
  }

  get deleteIncludedItem() {
    return $('//div[@class="FDServiceBuilderIncludedItems"]//button[text()="Delete"]');
  }

  get includedItemLookup() {
    return $('//div[@class="FDServiceBuilderIncludedItems"]//div[@data-name="itemLookup"]').$('input');
  }

  get advanceItemSettingButton() {
    return $('//button[text()="Advanced Item Settings"]');
  }

  get additionalItems() {
    return $('//a[@data-contentid="additional"]');
  }

  get addAdditionalItem() {
    return $('//div[@id="additional"]//button[@data-name="addItemBtn"]');
  }

  get AdditionalItemLookup() {
    return $('//div[@id="additional"]//div[@data-name="itemLookup"]//input');
  }

  get Save() {
    return $('//button[text()="Save"]');
  }
}

export const advanceItemSettingPage = new AdvanceItemSettingPage();
