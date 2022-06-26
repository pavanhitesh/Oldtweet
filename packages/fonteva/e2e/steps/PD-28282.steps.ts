import { After, Before, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$Contact, Fields$OrderApi__GL_Account__c } from '../../fonteva-schema';
import { salesOrderPage } from '../../pages/salesforce/salesorder.page';
import * as data from '../data/PD-28282.json';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-28282' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
  const ContactId = (await conn.query<Fields$Contact>(`SELECT Id From Contact WHERE Name = '${data.ContactName}'`))
    .records[0].Id;

  await conn.tooling.executeAnonymous(
    `Delete [SELECT Id FROM OrderApi__Known_Address__c WHERE OrderApi__Contact__c = '${ContactId}' AND OrderApi__Province__c = '${data.Adddress.OrderApi__Province__c}'];`,
  );

  data.Adddress.OrderApi__Contact__c = ContactId;
  await conn.create('OrderApi__Known_Address__c', data.Adddress);
});

After({ tags: '@TEST_PD-28282' }, async () => {
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderid);
  expect(salesOrderDeleted.success).toEqual(true);
});

Then('User verifies the Tax Item line AR account is {string}', async (arAccountName: string) => {
  localSharedData.salesOrderid = await (await salesOrderPage.getUrl()).split('/')[6];
  const ARAccountOnTaxLine = (
    await conn.query<Fields$OrderApi__GL_Account__c>(
      `SELECT Name FROM OrderApi__GL_Account__c WHERE Id In (SELECT OrderApi__AR_Account__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Is_Tax__c = true AND OrderApi__Sales_Order__c = '${localSharedData.salesOrderid}')`,
    )
  ).records[0].Name;
  expect(arAccountName).toEqual(ARAccountOnTaxLine);
});
