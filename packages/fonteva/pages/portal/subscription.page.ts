/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class SubscriptionPage extends WebPage {
  private subscriptionToRenewLocator!: string;

  private subscriptionToManageLocator!: string;

  private activeNamedSubscription!: string;

  get manage() {
    return $('//div[contains(@class, "LTECard")]//button[@data-name="manageSub"]');
  }

  get renew() {
    return $('//div[contains(@class, "LTECard")]//button[@data-name="renewSub"]');
  }

  get requiredActiveSubscription() {
    return $(this.activeNamedSubscription);
  }

  set activeSubscription(subscriptionName: string) {
    this.activeNamedSubscription = `//div[child::div["${subscriptionName}"]]//button[@data-name="renewSub"]`;
  }

  get expiredSubRenew() {
    return $('//div[contains(@class, "LTECard")]//button[@data-name="expiredRenewSub"]');
  }

  get viewInactiveSubscriptions() {
    return $('//span[text()="View Inactive Subscriptions"]');
  }

  set subscriptionToRenew(subscriptionId: string) {
    this.subscriptionToRenewLocator = `//button[@data-id="${subscriptionId}" and @data-name="renewSub"]`;
  }

  get renewSubscription() {
    return $(this.subscriptionToRenewLocator);
  }

  set subscriptionToManage(subscriptionId: string) {
    this.subscriptionToManageLocator = `//button[@data-id="${subscriptionId}" and @data-name="manageSub"]`;
  }

  get manageSubscription() {
    return $(this.subscriptionToManageLocator);
  }

  get members() {
    return $('//a[@title="Members"]');
  }
}

export const subscriptionPage = new SubscriptionPage();
