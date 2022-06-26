import { Then, Given, After } from '@cucumber/cucumber';
import { Fields$Account, Fields$Contact, Fields$OrderApi__Sales_Order__c } from 'packages/fonteva/fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

const state: { [key: string]: string } = {};

After({ tags: '@TEST_PD-27756' }, async () => {
  const deleteSO = await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrder as string);
  expect(deleteSO.success).toEqual(true);
});

Given(
  'User created New Sales Order with Contact as {string}, Account as {string} & Entity as {string}',
  async (contactName: string, accountName: string, entityType: string) => {
    const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${contactName}'`))
      .records[0].Id;
    const accountId = (await conn.query<Fields$Account>(`Select Id from Account Where Name = '${accountName}'`))
      .records[0].Id;
    const apexBody = `OrderApi__Sales_Order__c so = New OrderApi__Sales_Order__c(); 
    so.OrderApi__Entity__c = '${entityType}';
    so.OrderApi__Contact__c	= '${contactId}';
    so.OrderApi__Account__c	= '${accountId}';
    Insert so;`;
    const response = await conn.tooling.executeAnonymous(apexBody);
    expect(response.success).toEqual(true);
  },
);

Then(
  'User updated Sales Order record {string} or {string} or {string} value',
  async (entity: string, contact: string, account: string) => {
    if (entity) {
      const apexBody = `OrderApi__Sales_Order__c so = [Select Id , OrderApi__Entity__c from OrderApi__Sales_Order__c order by createdDate DESC limit 1];
      so.OrderApi__Entity__c = '${entity}';
      update so;`;
      const response = await conn.tooling.executeAnonymous(apexBody);
      expect(response.success).toEqual(true);
    }
    if (contact) {
      const contactId = (await conn.query<Fields$Contact>(`Select Id from Contact Where Name = '${contact}'`))
        .records[0].Id;
      const apexBody = `OrderApi__Sales_Order__c so = [Select Id , OrderApi__Contact__c from OrderApi__Sales_Order__c order by createdDate DESC limit 1];
      so.OrderApi__Contact__c = '${contactId}';
      update so;`;
      const response = await conn.tooling.executeAnonymous(apexBody);
      expect(response.success).toEqual(true);
    }
    if (account) {
      const accountId = (await conn.query<Fields$Account>(`Select Id from Account Where Name = '${account}'`))
        .records[0].Id;
      const apexBody = `OrderApi__Sales_Order__c so = [Select Id , OrderApi__Account__c from OrderApi__Sales_Order__c order by createdDate DESC limit 1];
      so.OrderApi__Account__c = '${accountId}';
      update so;`;
      const response = await conn.tooling.executeAnonymous(apexBody);
      expect(response.success).toEqual(true);
    }
  },
);

Then('User verified the Address updated in Sales Order record', async () => {
  const salesOrder = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `Select Id, OrderApi__Entity__c, OrderApi__Contact__c, OrderApi__Account__c, OrderApi__Billing_Contact__c, OrderApi__Billing_Street__c, OrderApi__Billing_City__c, OrderApi__Billing_State__c, OrderApi__Billing_Postal_Code__c, OrderApi__Billing_Country__c, OrderApi__Shipping_Contact__c, OrderApi__Shipping_Street__c, OrderApi__Shipping_City__c, OrderApi__Shipping_State__c, OrderApi__Shipping_Postal_Code__c, OrderApi__Shipping_Country__c from OrderApi__Sales_Order__c order by createdDate DESC limit 1`,
    )
  ).records[0];
  state.salesOrder = salesOrder.Id;
  if (salesOrder.OrderApi__Entity__c === 'Contact') {
    const contactAddress = (
      await conn.query<Fields$Contact>(
        `SELECT Name, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry from Contact WHERE Id = '${salesOrder.OrderApi__Contact__c}'`,
      )
    ).records[0];

    expect(salesOrder.OrderApi__Billing_Street__c).toEqual(contactAddress.MailingStreet);
    expect(salesOrder.OrderApi__Billing_City__c).toEqual(contactAddress.MailingCity);
    expect(salesOrder.OrderApi__Billing_State__c).toEqual(contactAddress.MailingState);
    expect(salesOrder.OrderApi__Billing_Postal_Code__c).toEqual(contactAddress.MailingPostalCode);
    expect(salesOrder.OrderApi__Billing_Country__c).toEqual(contactAddress.MailingCountry);
    expect(salesOrder.OrderApi__Shipping_Street__c).toEqual(contactAddress.MailingStreet);
    expect(salesOrder.OrderApi__Shipping_City__c).toEqual(contactAddress.MailingCity);
    expect(salesOrder.OrderApi__Shipping_State__c).toEqual(contactAddress.MailingState);
    expect(salesOrder.OrderApi__Shipping_Postal_Code__c).toEqual(contactAddress.MailingPostalCode);
    expect(salesOrder.OrderApi__Shipping_Country__c).toEqual(contactAddress.MailingCountry);
    expect(salesOrder.OrderApi__Billing_Contact__c).toEqual(contactAddress.Name);
    expect(salesOrder.OrderApi__Shipping_Contact__c).toEqual(contactAddress.Name);
  } else {
    const accountAddress = (
      await conn.query<Fields$Account>(
        `SELECT BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry from Account WHERE Id = '${salesOrder.OrderApi__Account__c}'`,
      )
    ).records[0];

    expect(salesOrder.OrderApi__Billing_Street__c).toEqual(accountAddress.BillingStreet);
    expect(salesOrder.OrderApi__Billing_City__c).toEqual(accountAddress.BillingCity);
    expect(salesOrder.OrderApi__Billing_State__c).toEqual(accountAddress.BillingState);
    expect(salesOrder.OrderApi__Billing_Postal_Code__c).toEqual(accountAddress.BillingPostalCode);
    expect(salesOrder.OrderApi__Billing_Country__c).toEqual(accountAddress.BillingCountry);
    expect(salesOrder.OrderApi__Shipping_Street__c).toEqual(accountAddress.ShippingStreet);
    expect(salesOrder.OrderApi__Shipping_City__c).toEqual(accountAddress.ShippingCity);
    expect(salesOrder.OrderApi__Shipping_State__c).toEqual(accountAddress.ShippingState);
    expect(salesOrder.OrderApi__Shipping_Postal_Code__c).toEqual(accountAddress.ShippingPostalCode);
    expect(salesOrder.OrderApi__Shipping_Country__c).toEqual(accountAddress.ShippingCountry);
  }
});
