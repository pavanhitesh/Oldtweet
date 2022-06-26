import { When, Then, After } from '@cucumber/cucumber';
import { Fields$OrderApi__Price_Rule__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';

After({ tags: '@TEST_PD-29130' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('portalSO')) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);
});

When('User navigates to view cart page', async () => {
  await commonPortalPage.clickViewCartbutton();
  const orgId = await browser.sharedStore.get('organizationId');
  const cookieSalesOrderId = JSON.parse(
    (await browser.getCookies([`apex__${orgId}-fonteva-community-shopping-cart`]))[0].value,
  ).salesOrderId;
  browser.sharedStore.set('portalSO', cookieSalesOrderId);
  expect(await commonPortalPage.buttonCheckout.isDisplayed()).toEqual(true);
});

Then(
  'User verifies total amount due is displayed with {string} price rule for item {string}',
  async (ruleName: string, itemName: string) => {
    const configuredPrice = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${itemName}' and Name = '${ruleName}'`,
      )
    ).records[0].OrderApi__Price__c;
    expect(await shoppingCartPage.getText(await shoppingCartPage.totalCheckOutAmount)).toEqual(
      `$${configuredPrice}.00`,
    );
  },
);
