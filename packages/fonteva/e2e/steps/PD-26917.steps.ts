import { After, Before, Then, When } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string | number } = {};

Before({ tags: '@TEST_PD-27189' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27189' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

When(
  'User is able to expand the Item details of {string} and update the Qty of the Additional Package item to {int}',
  async (itemToExpand: string, optionalItemQty: number) => {
    await rapidOrderEntryPage.updateOptionalPackageItemQty(itemToExpand, optionalItemQty);
    expect(parseInt(await rapidOrderEntryPage.getValue(await rapidOrderEntryPage.optionalPackageItemQty), 10)).toEqual(
      optionalItemQty,
    );
    localSharedData.Name = await rapidOrderEntryPage.getText(await rapidOrderEntryPage.addedOptionalItemName);
    localSharedData.price = await rapidOrderEntryPage.getOptionalItemPrice();
    localSharedData.Qty = optionalItemQty;
  },
);

Then('User verifies the amount for optional Item is displayed correct based on Qty', async (): Promise<void> => {
  await applyPaymentPage.waitForPresence(await applyPaymentPage.orderInfoHeaderApplyPaymentPage, 360000);
  await applyPaymentPage.click(await applyPaymentPage.openOrderDetailsIconApplyPaymentPage);
  await applyPaymentPage.waitForPresence(await applyPaymentPage.orderDetailsTableApplyPaymentPage);
  const actualItemPriceCalculated = await applyPaymentPage.getFinalItemPriceApplyPaymentPage(
    localSharedData.Name as string,
  );
  const expectedItemPriceCalculated = (localSharedData.Qty as number) * (localSharedData.price as number);
  expect(actualItemPriceCalculated).toBe(expectedItemPriceCalculated);
});
