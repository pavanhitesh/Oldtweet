import { After, Before, DataTable, When } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-27084' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27084' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${localSharedData.SalesOrderNumber}'`,
    )
  ).records[0].Id;

  const deleteSO = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId);
  expect(deleteSO.success).toEqual(true);
});

When('User is able to add below items in Rapid order entry page', async (itemName: DataTable) => {
  localSharedData.SalesOrderNumber = await (
    await rapidOrderEntryPage.getText(await rapidOrderEntryPage.salesOrderNumber)
  ).replace('#', '');
  const itemNames = itemName.hashes();
  await itemNames.reduce(async (memo, item) => {
    await memo;
    await rapidOrderEntryPage.addItemToOrder(item.ItemName);
    expect(await rapidOrderEntryPage.verifyItemAddedToOrder(item.ItemName)).toBe(true);
  }, undefined);
});

When('User selects Payment type as {string} and Navigate to Apply payment pages', async (argPaymentType) => {
  await rapidOrderEntryPage.selectPaymentTypeAndProceedFurther(argPaymentType);
  await rapidOrderEntryPage.waitForPresence(await applyPaymentPage.applyPaymentPageHeader, MilliSeconds.XXXL);
  expect(await rapidOrderEntryPage.isDisplayed(await applyPaymentPage.applyPaymentPageHeader)).toBe(true);
});

When('User select the payment type as {string} and completes the Payment successfully', async (paymentMode) => {
  await applyPaymentPage.selectPaymentTypeInApplyPayment(paymentMode);
  await applyPaymentPage.typeReferenceNumber('TestRef1234');
  await applyPaymentPage.clickApplyPayments();
  expect(await applyPaymentPage.isDisplayed(await applyPaymentPage.receiptHeader)).toBe(true);
});
