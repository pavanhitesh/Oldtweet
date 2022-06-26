/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class CompanyOrdersPage extends WebPage {
  get pay() {
    return $('//c-pfm-button[@data-name="statementBuilderActionButtonPay"]/button');
  }

  get orderContainer() {
    return $('.siteforceStarterBody');
  }

  get allOrders() {
    return $('//span[text()="Select All"]/..');
  }

  async clickOpenOrdersTab() {
    const openOrders = await (await this.orderContainer).shadow$('a[data-label="Open Orders"]');
    await super.click(openOrders);
    const tableContainer = await (await this.orderContainer).shadow$('[data-name="statementBuilderTableContainer"]');
    await super.waitForPresence(tableContainer);
  }

  async selectAllOrders() {
    const tableContainer = await (await this.orderContainer).shadow$('[data-name="statementBuilderTableContainer"]');
    await super.waitForPresence(tableContainer);
    await super.click(await this.allOrders);
  }

  async clickPay() {
    await super.click(await this.pay);
  }
}

export const companyOrdersPage = new CompanyOrdersPage();
