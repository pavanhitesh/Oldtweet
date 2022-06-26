import { After, Before, Then, When } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$OrderApi__Item__c, Fields$OrderApi__Sales_Order_Line__c } from '../../fonteva-schema';
import { taxAndShippingPage } from '../../pages/salesforce/tax-and-shipping.page';
import { applyPaymentPage } from '../../pages/salesforce/apply-payment.page';

const localSharedData: { [key: string]: number } = {};

Before({ tags: '@REQ_PD-29117' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@REQ_PD-29117' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('SalesOrderId')) as string,
  );
  expect(salesOrderDeleted.success).toEqual(true);
});

When(`User Selects the shipping method {string}`, async (shippingMethodName: string) => {
  const shippingMethodDetails = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT Id, OrderApi__Price__c FROM OrderApi__Item__c WHERE Name = '${shippingMethodName}'`,
    )
  ).records[0];

  localSharedData.listPrice = await (shippingMethodDetails.OrderApi__Price__c as number);

  await taxAndShippingPage.selectByAttribute(
    await taxAndShippingPage.shippingMethod,
    'value',
    await shippingMethodDetails.Id,
  );

  expect(
    await browser.execute(
      `return arguments[0].label`,
      await (await taxAndShippingPage.shippingMethod).$(`select option:checked`),
    ),
  ).toHaveTextContaining(shippingMethodName);
});

When(`User overrides the shipping price to {int}`, async (shippingPrice: number) => {
  await taxAndShippingPage.type(await taxAndShippingPage.shippingCost, shippingPrice);
  expect(await taxAndShippingPage.getValue(await taxAndShippingPage.shippingCost)).toBe(shippingPrice.toString());
});

When(`User proceeds to paymentpage`, async () => {
  await taxAndShippingPage.click(await taxAndShippingPage.continue);
  await applyPaymentPage.waitForClickable(await applyPaymentPage.applyPayment);
  expect(await (await applyPaymentPage.balanceDueAmount).isDisplayed()).toEqual(true);
});

Then(`User verifies shipping SalesOrderLine item is created for the salesorder`, async () => {
  const shippingSOLItemRecords = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT OrderApi__List_Price__c, OrderApi__Total__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Is_Shipping_Rate__c = true AND OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
        'SalesOrderId',
      )}'`,
    )
  ).records;
  expect(shippingSOLItemRecords.length).toBe(1);
  expect(await localSharedData.listPrice).toBe(shippingSOLItemRecords[0].OrderApi__List_Price__c);
  expect(shippingSOLItemRecords[0].OrderApi__Total__c).toBe(0);
});
