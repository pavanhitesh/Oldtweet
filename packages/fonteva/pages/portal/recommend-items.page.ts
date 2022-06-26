/* eslint-disable class-methods-use-this */
import { Fields$OrderApi__Package_Item__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { WebPage } from '../../../../globals/web/web.page';

class RecommendedItemsPage extends WebPage {
  private recommendedItemName!: string;

  private attendeePackageItem!: string;

  get recommendeditemLink() {
    return $('//a[@data-name="recommended"]');
  }

  get quantity() {
    return $('//select[@name="qty"]');
  }

  get addToOrder() {
    return $('//button[@aria-label="Add To Order"]');
  }

  get recommendedItemId() {
    return this.recommendedItemName;
  }

  set recommendedItemId(recommendedItemId: string) {
    this.recommendedItemName = `//button[@data-id='${recommendedItemId}']`;
  }

  get recommendedItem() {
    return $(this.recommendedItemId);
  }

  get continue() {
    return $('//button[@data-name="nextStep"]');
  }

  get attendeePicklist() {
    return $(`//div[@data-name="attendeePicklist"]`);
  }

  get attendeePicklistInput() {
    return $(`//div[@data-name="attendeePicklist"]//input`);
  }

  get attendeePicklistDropdown() {
    return $(`//div[@data-name="attendeePicklist"]//select`);
  }

  set packageItemforAttendee(attendeeName: string) {
    this.attendeePackageItem = `//div[@data-name="summaryDetailDiv"]//span[contains(.,'${attendeeName}')]/../following-sibling::div//div[@class="fonteva-summary_item-package"]//div[@data-id="reg-line-name"]`;
  }

  get attendeeAddedPackageItem() {
    return $(this.attendeePackageItem);
  }

  async selectRecommendedItem(itemName: string) {
    const itemId = (
      await conn.query<Fields$OrderApi__Package_Item__c>(
        `SELECT Id FROM OrderApi__Package_Item__c WHERE OrderApi__Item__r.Name ='${itemName}' AND EventApi__Ticket_Type__r.Name = '${await browser.sharedStore.get(
          'ticketName',
        )}' `,
      )
    ).records[0].Id;
    this.recommendedItemId = itemId;
    await super.click(await this.recommendedItem);
  }

  async selectAttendee(attendeeName: string) {
    await super.click(await this.attendeePicklist);
    await super.slowTypeFlex(await this.attendeePicklistInput, attendeeName);
    await super.Keyboard('Enter');
  }
}
export const recommendedItemsPage = new RecommendedItemsPage();
