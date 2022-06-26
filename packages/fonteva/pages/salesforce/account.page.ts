/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { rapidOrderEntryPage } from './rapid-order-entry.page';
import { conn } from '../../shared/helpers/force.helper';

class AccountPage extends WebPage {
  get accountName() {
    return $(
      `//div[text()='Account']/..//slot[@name='primaryField']//div[@data-aura-class='sfaOutputNameWithHierarchyIcon']/lightning-formatted-text`,
    );
  }

  get rapidOrderEntry() {
    return $(`//button[text()='Rapid Order Entry']`);
  }

  async deleteCreditMemo(accountName: string) {
    await conn.tooling.executeAnonymous(
      `Delete [SELECT Id FROM OrderApi__Credit_Memo__c WHERE OrderApi__Account__c IN (SELECT Id FROM Account where Name = '${accountName}')];`,
    );
  }

  async deleteSalesOrder(account: string) {
    await conn.tooling.executeAnonymous(
      `Delete [SELECT Id FROM OrderApi__Sales_Order__c WHERE OrderApi__Account__c in (SELECT Id FROM Account where Name = '${account}')];`,
    );
  }

  async deleteReceipts(accountName: string) {
    await conn.tooling.executeAnonymous(
      `Delete [SELECT Id FROM OrderApi__Receipt__c WHERE OrderApi__Account__c in (SELECT Id FROM Account where Name = '${accountName}')]`,
    );
  }

  async openAccountPage(accountId: string | undefined) {
    await super.open(`/lightning/r/Account/${accountId}/view`);
    await super.sleep(MilliSeconds.XXS);
    await super.waitForPresence(await this.accountName);
  }

  async openRapidOrderEntryPage() {
    await super.waitForClickable(await this.rapidOrderEntry, MilliSeconds.XXL);
    await super.click(await this.rapidOrderEntry);
    await super.waitForAjaxCall(MilliSeconds.XXL);
    await super.waitForPresence(await rapidOrderEntryPage.itemQuickAddTextBox);
  }
}

export const accountPage = new AccountPage();
