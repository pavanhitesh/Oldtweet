/* eslint-disable class-methods-use-this */
import {
  Fields$Contact,
  Fields$OrderApi__Sales_Order__c,
  Fields$OrderApi__Subscription__c,
  Fields$OrderApi__Known_Address__c,
  Fields$OrderApi__Payment_Method__c,
} from '../../fonteva-schema';
import { WebPage } from '../../../../globals/web/web.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { rapidOrderEntryPage } from './rapid-order-entry.page';

class ContactPage extends WebPage {
  get rapidOrderEntry() {
    return $('//button[text() ="Rapid Order Entry"]');
  }

  get contactName() {
    return $(`//slot[@name="primaryField"]//span[@data-aura-class='uiOutputText']`);
  }

  async deleteSalesOrder(contact: string) {
    const result = await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE OrderApi__Contact__c in (SELECT Id FROM Contact where Name = '${contact}')`,
    );
    const salesOrderId = result.records.map((item) => item.Id);
    await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  }

  async deleteSubscription(contact: string) {
    const result = await conn.query<Fields$OrderApi__Subscription__c>(
      `SELECT Id FROM OrderApi__Subscription__c WHERE OrderApi__Contact__r.Name = '${contact}'`,
    );
    const subscriptionId = result.records.map((item) => item.Id);
    const subscriptionDeletedResponse = await conn.destroy('OrderApi__Subscription__c', subscriptionId);
    return subscriptionDeletedResponse;
  }

  async deleteCreditMemo(contactName: string) {
    await conn.tooling.executeAnonymous(
      `Delete [SELECT Id FROM OrderApi__Credit_Memo__c WHERE OrderApi__Contact__c IN (SELECT Id FROM Contact where Name = '${contactName}')];`,
    );
  }

  async openContactPage(contactId: string) {
    await super.open(`/lightning/r/Contact/${contactId}/view`);
    await super.sleep(MilliSeconds.XXS);
    await super.waitForPresence(await this.contactName);
  }

  async openRapidOrderEntryPage() {
    await super.waitForClickable(await this.rapidOrderEntry, MilliSeconds.XXL);
    await super.click(await this.rapidOrderEntry);
    await super.waitForAjaxCall(MilliSeconds.XXL);
    await super.waitForPresence(await rapidOrderEntryPage.itemQuickAddTextBox);
  }

  async deletePaymentMethod(contactName: string) {
    const deleteQuery = `DELETE [SELECT Id From OrderApi__Payment_Method__c WHERE OrderApi__Contact__r.Name = '${contactName}'];`;
    await conn.tooling.executeAnonymous(deleteQuery);
  }

  async addNewPaymentMethod(contactName: string, cardType: string, lastfourDigits: string) {
    const paymentMethodToken = (
      await conn.query<Fields$OrderApi__Payment_Method__c>(`
        SELECT OrderApi__Payment_Method_Token__c FROM OrderApi__Payment_Method__c WHERE OrderApi__Is_Active__c = true AND 
        OrderApi__Is_Valid__c = true AND OrderApi__Contact__c IN (SELECT Id from Contact WHERE Name = 'ONE_INVOICE DONOTMODIFY')`)
    ).records[0].OrderApi__Payment_Method_Token__c as string;

    const contactId = (await conn.query<Fields$Contact>(`SELECT Id from Contact WHERE Name = '${contactName}'`))
      .records[0].Id;

    const paymentMethodData = {
      OrderApi__Entity__c: 'Contact',
      OrderApi__Contact__c: contactId,
      OrderApi__Payment_Method_Token__c: paymentMethodToken,
      OrderApi__Payment_Method_Type__c: 'credit_card',
      OrderApi__Year__c: new Date(Date.now()).getFullYear() + 5,
      OrderApi__Month__c: 6,
      OrderApi__Is_Active__c: true,
      OrderApi__Is_Valid__c: true,
      OrderApi__Is_Expired__c: false,
      OrderApi__Is_Declined__c: false,
      OrderApi__Card_Type__c: cardType,
      OrderApi__Number__c: `XXXX-XXXX-XXXX-${lastfourDigits}`,
      OrderApi__Last_Four_Digits__c: lastfourDigits,
    };

    return conn.create('OrderApi__Payment_Method__c', paymentMethodData);
  }

  async deleteKnownAddress(contactName: string) {
    const knownAddressRecords = (
      await conn.query<Fields$OrderApi__Known_Address__c>(
        `SELECT Id FROM OrderApi__Known_Address__c WHERE OrderApi__Contact__c in (SELECT Id FROM Contact where Name = '${contactName}')`,
      )
    ).records;
    const knownAddressIdList = knownAddressRecords.map((item) => item.Id);
    await conn.destroy('OrderApi__Known_Address__c', knownAddressIdList);
  }
}
export const contactPage = new ContactPage();
