import { After, Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { orderPage } from '../../pages/portal/orders.page';

Before({ tags: '@TEST_PD-28868' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-28868' }, async () => {
  const deleteSalesOrder = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('salesOrderId')) as string,
  );
  expect(deleteSalesOrder.success).toEqual(true);
});

Then('User verifies no balance due displayed for the sales order and in the document', async () => {
  expect(await orderPage.getText(await orderPage.getBalanceDueOnAllOrders)).toEqual('$0.00');

  orderPage.viewOrders = (await browser.sharedStore.get('salesOrderId')) as string;
  await orderPage.click(await orderPage.viewOrderFromAllOrders);
  await orderPage.waitForPresence(await orderPage.balanceDueOnDocumnet);
  expect(await orderPage.getText(await orderPage.balanceDueOnDocumnet)).toEqual('$0.00');
});
