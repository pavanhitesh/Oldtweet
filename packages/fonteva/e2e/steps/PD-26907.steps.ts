import { Before, When, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-27755' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

When(
  'User updates subscriber contact to other contact {string} for a item {string}',
  async (contactName: string, item: string) => {
    await rapidOrderEntryPage.expandItemtoViewDetails(item);
    await rapidOrderEntryPage.changeSubscriptionContact(contactName);
  },
);

Then('User verifies the sales order assignment is assigned to {string} contact', async (contactName: string) => {
  const url = await rapidOrderEntryPage.getUrl();
  const receiptId = url.split('/')[6];
  const assignmentContact = (
    await conn.query(
      `SELECT OrderApi__Contact__r.Name FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c in (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Id = '${receiptId}')`,
    )
  ).records[0].OrderApi__Contact__r.Name;
  expect(assignmentContact).toEqual(contactName);
});
