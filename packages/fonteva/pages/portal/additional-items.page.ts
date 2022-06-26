/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class AdditionalItemsPage extends WebPage {
  private additionalItemOnModal!: string;

  private additionalItem!: string;

  get continue() {
    return $('//button[@data-name="additionalNextBtn"]');
  }

  get addItem() {
    return $('//div[@class="pfm-detail_group_dropdown_addItem"]');
  }

  get modalHeader() {
    return $('//div[contains(@id, "modal_addtlItems")]//h2[@data-id="modalTitle"]');
  }

  get change() {
    return $('//strong[contains(.,"Additional Items Header")]//following::div[1]//a');
  }

  set modalAdditionalItem(itemName: string) {
    this.additionalItemOnModal = `//div[contains(@id,"modal_addtlItems")]//div[@data-text="${itemName}"]`;
  }

  get selectAdditionalItemOnModal() {
    return $(this.additionalItemOnModal);
  }

  set singleAdditionalItem(itemName: string) {
    this.additionalItem = `//div[@data-text="${itemName}"]`;
  }

  get selectAdditionalItem() {
    return $(this.additionalItem);
  }
}

export const additionalItemsPage = new AdditionalItemsPage();
