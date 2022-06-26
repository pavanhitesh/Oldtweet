/* eslint-disable class-methods-use-this */
import { WebPage } from '../../../../globals/web/web.page';

class OrdersPage extends WebPage {
  get orderContainer() {
    return $('.siteforceStarterBody');
  }

  get viewOrder() {
    return $('//tr//button[@aria-label="View Order"]');
  }

  get balanceDueOnDocumnet() {
    return $(
      `//c-pfm-tile[@class='summaryTile']//c-pfm-output-field[@data-name='ordersTotalBalanceDue']//span[@class='currencyInputSpan']`,
    );
  }

  balanceDue!: string;

  get getBalanceDueOnOrders() {
    return this.balanceDue;
  }

  set getBalanceDueOnOrders(salesOrderId: string) {
    this.balanceDue = `//tr[@data-row-key-value='${salesOrderId}']//td[@data-label='Balance Due']//span[@class='currencyInputSpan']`;
  }

  get getBalanceDueOnAllOrders() {
    return $(this.getBalanceDueOnOrders);
  }

  viewOrders!: string;

  get viewOrderFromOrders() {
    return this.viewOrders;
  }

  set viewOrderFromOrders(salesOrderId: string) {
    this.viewOrders = `//tr[@data-row-key-value='${salesOrderId}']//td//button[@aria-label='View Order']`;
  }

  get viewOrderFromAllOrders() {
    return $(this.viewOrderFromOrders);
  }

  async clickAllOrdersTab() {
    const allOrders = await (await this.orderContainer).shadow$('a[data-label="All Orders"]');
    await super.click(allOrders);
    const tableContainer = await (await this.orderContainer).shadow$('[data-name="statementBuilderTableContainer"]');
    await super.waitForPresence(tableContainer);
  }

  async getSalesOrderList() {
    const salesOrders: Array<string> = [];
    const tableContainer = await (await this.orderContainer).shadow$('[data-name="statementBuilderTableContainer"]');
    await super.waitForPresence(tableContainer);
    const ordersList = await (await this.orderContainer).shadow$$('th[data-label="Order/Invoice #"]');
    await Promise.all(
      ordersList.map(async (order) => {
        const salesOrder = await super.getText(order);
        salesOrders.push(salesOrder);
      }),
    );
    return salesOrders;
  }
}

export const orderPage = new OrdersPage();
