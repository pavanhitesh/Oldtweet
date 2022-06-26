import { After, Before, Then, When } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import { Fields$Contact, Fields$OrderApi__Receipt__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';

Before({ tags: '@TEST_PD-29528' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29528' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);
});

When(
  `User exit to sales order and updates the sales order contact with contact having other account {string}`,
  async (contactName: string) => {
    await rapidOrderEntryPage.click(await rapidOrderEntryPage.exit);
    await salesOrderPage.waitForPresence(await salesOrderPage.salesOrderNumber);
    const contactId = (await conn.query<Fields$Contact>(`SELECT Id FROM Contact WHERE Name='${contactName}'`))
      .records[0].Id;
    const salesOrderApexBody = `OrderApi__Sales_Order__c SOL = [Select Id from OrderApi__Sales_Order__c Where Name = '${await browser.sharedStore.get(
      'SalesOrderNumber',
    )}' ];
        SOL.OrderApi__Contact__c = '${contactId}';
        update SOL;`;
    await conn.tooling.executeAnonymous(salesOrderApexBody);
  },
);

Then(`User verifies the account on receipt should match the account on salesOrder`, async () => {
  const accountOnSalesOrder = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `Select OrderApi__Account__c from OrderApi__Sales_Order__c where Name = '${await browser.sharedStore.get(
        'SalesOrderNumber',
      )}'`,
    )
  ).records[0].OrderApi__Account__c;
  const accountOnReceipt = (
    await conn.query<Fields$OrderApi__Receipt__c>(
      `Select OrderApi__Account__c from OrderApi__Receipt__c where Id = '${await browser.sharedStore.get(
        'receiptId',
      )}'`,
    )
  ).records[0].OrderApi__Account__c;
  expect(accountOnReceipt).toEqual(accountOnSalesOrder);
});
