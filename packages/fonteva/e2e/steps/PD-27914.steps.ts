import { After, Then } from '@cucumber/cucumber';
import { Fields$Account, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

After({ tags: '@TEST_PD-28340' }, async () => {
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy(((await browser.sharedStore.get('salesOrderIds')) as string[])[0] as string);
  expect(deleteSO.success).toEqual(true);
});

Then(`User verifies the Billing and Shipping address populated on Sales Order is from Account`, async () => {
  const accountAddressData = (
    await conn.query<Fields$Account>(
      `SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, 
      ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry 
      FROM Account WHERE Id IN (SELECT OrderApi__Account__c FROM OrderApi__Sales_Order__c WHERE Id = '${
        ((await browser.sharedStore.get('salesOrderIds')) as string[])[0]
      }')`,
    )
  ).records[0];

  const salesOrderAddressData = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT OrderApi__Billing_Street__c, OrderApi__Billing_City__c, OrderApi__Billing_State__c, OrderApi__Billing_Postal_Code__c, OrderApi__Billing_Country__c,
      OrderApi__Shipping_Street__c, OrderApi__Shipping_City__c, OrderApi__Shipping_State__c, OrderApi__Shipping_Postal_Code__c, OrderApi__Shipping_Country__c
      FROM OrderApi__Sales_Order__c WHERE Id = '${((await browser.sharedStore.get('salesOrderIds')) as string[])[0]}'`,
    )
  ).records[0];

  expect(accountAddressData.BillingStreet).toEqual(salesOrderAddressData.OrderApi__Billing_Street__c);
  expect(accountAddressData.BillingCity).toEqual(salesOrderAddressData.OrderApi__Billing_City__c);
  expect(accountAddressData.BillingState).toEqual(salesOrderAddressData.OrderApi__Billing_State__c);
  expect(accountAddressData.BillingPostalCode).toEqual(salesOrderAddressData.OrderApi__Billing_Postal_Code__c);
  expect(accountAddressData.BillingCountry).toEqual(salesOrderAddressData.OrderApi__Billing_Country__c);
  expect(accountAddressData.ShippingStreet).toEqual(salesOrderAddressData.OrderApi__Shipping_Street__c);
  expect(accountAddressData.ShippingCity).toEqual(salesOrderAddressData.OrderApi__Shipping_City__c);
  expect(accountAddressData.ShippingState).toEqual(salesOrderAddressData.OrderApi__Shipping_State__c);
  expect(accountAddressData.ShippingPostalCode).toEqual(salesOrderAddressData.OrderApi__Shipping_Postal_Code__c);
  expect(accountAddressData.ShippingCountry).toEqual(salesOrderAddressData.OrderApi__Shipping_Country__c);
});
