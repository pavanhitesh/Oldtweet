import { When, Then, After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$OrderApi__Price_Rule__c } from '../../fonteva-schema';
import { commonPortalPage } from '../../pages/portal/common.page';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';

After({ tags: '@TEST_PD-29542' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('portalSO')) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);
});

When('User enter the discount code {string} in the order summary page', async (discountCode: string) => {
  await commonPortalPage.waitForPresence(await commonPortalPage.textBoxSourceCode);
  await commonPortalPage.setDiscountCode(discountCode);
  expect(await commonPortalPage.isDisplayed(await commonPortalPage.valueDiscountApplied)).toEqual(true);
});

Then(
  'User verfies the price rule {string} discount price is applied for the item {string}',
  async (priceRule: string, itemName: string) => {
    const configuredPrice = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${itemName}' and Name = '${priceRule}'`,
      )
    ).records[0].OrderApi__Price__c;
    expect(await shoppingCartPage.getText(await shoppingCartPage.totalCheckOutAmount)).toEqual(
      `$${configuredPrice}.00`,
    );
  },
);
