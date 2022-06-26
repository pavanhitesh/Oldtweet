/* eslint-disable class-methods-use-this */
/* eslint-disable no-console */
import * as faker from 'faker';
import { Fields$LTE__Menu_Item__c, Fields$LTE__Site__c, Fields$OrderApi__Badge_Type__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { WebPage } from '../../../../globals/web/web.page';

class CommunitySiteNewMenuPage extends WebPage {
  get communityNewMenuHeader() {
    return $('//h2[@data-id="modalTitle"]');
  }

  get menuName() {
    return $('//div[@data-label="Name"]/input');
  }

  get menuType() {
    return $('//select[@name="Type"]');
  }

  get menuUrl() {
    return $('//div[@data-label="URL"]/input');
  }

  get save() {
    return $('//button[@data-label="Save"]');
  }

  get externalUrlValidation() {
    return $('//div[@class="iziToast-body"]/p');
  }

  async addMenuItem(communitySiteName: string) {
    const communitySiteId = await (
      await conn.query<Fields$LTE__Site__c>(`SELECT Id FROM LTE__Site__c WHERE Name='${communitySiteName}'`)
    ).records[0].Id;
    await browser.sharedStore.set('menuItemName', faker.name.firstName());
    const menuItemData = {
      Name: `${await browser.sharedStore.get('menuItemName')}`,
      LTE__Type__c: 'External URL',
      LTE__URL__c: 'https://www.google.com',
      LTE__Display_Order__c: 5,
      LTE__Site__c: communitySiteId,
    };
    return conn.create('LTE__Menu_Item__c', menuItemData);
  }

  async addAccessPermissionToMenuItem(menuItem: string, badgeName: string) {
    const badgeId = await (
      await conn.query<Fields$OrderApi__Badge_Type__c>(
        `SELECT Id FROM OrderApi__Badge_Type__c WHERE Name='${badgeName}'`,
      )
    ).records[0].Id;
    const menuItemId = await (
      await conn.query<Fields$LTE__Menu_Item__c>(`SELECT Id FROM LTE__Menu_Item__c WHERE Name='${menuItem}'`)
    ).records[0].Id;
    const accessPermission = {
      LTE__Menu_Item__c: menuItemId,
      OrderApi__Badge_Type__c: badgeId,
    };
    return conn.create('OrderApi__Access_Permission__c', accessPermission);
  }
}
export const communitySiteNewMenuPage = new CommunitySiteNewMenuPage();
