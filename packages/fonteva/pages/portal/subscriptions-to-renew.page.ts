/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class SubscriptionToRenewPage extends WebPage {
  private assignMembersCheckbox!: string;

  private autoRenewChkBox!: string;

  private autoRenewTxt!: string;

  private noAutoRenewTxt!: string;

  private renewSubscriptionItem!: string;

  private assignMember_RoleSection!: string;

  set assignMemberRole_Name(contactName: string) {
    this.assignMember_RoleSection = `//td[@data-name="Name"]/span[text()='${contactName}']/following::div/td[@data-name='Role']`;
  }

  get assignMemberRoleSection() {
    return $(this.assignMember_RoleSection);
  }

  get assignMemberRoleDropDown() {
    return $(this.assignMember_RoleSection).$(`select`);
  }

  get renewHeader() {
    return $('//h1[text() = "Renew"]');
  }

  get change() {
    return $('//div[@class="subscription-change"]//button');
  }

  set assignMembertoSelect(contacName: string) {
    this.assignMembersCheckbox = `//td[@data-name="Name"]/span[text()='${contacName}']/../preceding-sibling::td/lightning-input//input`;
  }

  get assignMemberSelectCheckbox() {
    return $(this.assignMembersCheckbox);
  }

  set subscriptionToRenew(subscriptionItem: string) {
    this.renewSubscriptionItem = `//div[text() = '${subscriptionItem}'] /parent::div /parent::div /parent::div //button[text() = 'Renew']`;
  }

  get renewSubscription() {
    return $(this.renewSubscriptionItem);
  }

  set autoRenewCheckBoxSet(itemName: string) {
    this.autoRenewChkBox = `//div[text()="${itemName}"]/ancestor::div/following::input`;
  }

  get autoRenewCheckBox() {
    return $(this.autoRenewChkBox);
  }

  set autoRenewTextSet(itemName: string) {
    this.autoRenewTxt = `//div[text()="${itemName}"]/ancestor::div/following::span[text()="Auto Renew"]`;
  }

  get autoRenewText() {
    return $(this.autoRenewTxt);
  }

  set noAutoRenewTextSet(itemName: string) {
    this.noAutoRenewTxt = `//div[text()="${itemName}"]/ancestor::div/following::span[text()="Auto Renew Not Available"]`;
  }

  get noAutoRenewText() {
    return $(this.noAutoRenewTxt);
  }

  async identifyRenewSubscriptionBlock(itemName: string) {
    this.autoRenewCheckBoxSet = itemName;
    this.autoRenewTextSet = itemName;
    this.noAutoRenewTextSet = itemName;
  }
}

export const subscriptionToRenewPage = new SubscriptionToRenewPage();
