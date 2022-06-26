import { After, Before, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { salesOrderLinePage } from '../../pages/salesforce/salesorderline.page';
import { Fields$OrderApi__Sales_Order_Line__c } from '../../fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

let salesOrderLineData: { Id: string; OrderApi__Sales_Order__r: { Id: string } };

Before({ tags: '@TEST_PD-29149' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(`User validates that non-financial fields on sales order are changeable`, async () => {
  [salesOrderLineData] = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`
  SELECT Id, OrderApi__Sales_Order__r.Id FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
    'SalesOrderNumber',
  )}' AND OrderApi__Item_Name__c = '${await browser.sharedStore.get('itemName')}'`)
  ).records as Array<unknown> as Array<{ Id: string; OrderApi__Sales_Order__r: { Id: string } }>;
  await loginPage.open(`/${salesOrderLineData.Id}`);
  await salesOrderLinePage.click(await salesOrderLinePage.editShippingTrackingNumber);
  const generatedShippingTrackingNumber = faker.datatype.number({ min: 10000, max: 99999 });
  await salesOrderLinePage.type(await salesOrderLinePage.shippingTrackingNumberInput, generatedShippingTrackingNumber);
  await salesOrderLinePage.click(await salesOrderLinePage.saveEdit);
  await salesOrderLinePage.sleep(MilliSeconds.XXXS);
  const salesOrderShippingNumber = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(`
  SELECT OrderApi__Shipping_Tracking_Number__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__r.Name = '${await browser.sharedStore.get(
    'SalesOrderNumber',
  )}'`)
  ).records[0].OrderApi__Shipping_Tracking_Number__c;
  expect(salesOrderShippingNumber).toEqual(generatedShippingTrackingNumber.toString());
});

After({ tags: '@TEST_PD-29149' }, async () => {
  await conn.destroy('OrderApi__Sales_Order__c', salesOrderLineData.OrderApi__Sales_Order__r.Id);
});
