import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$Account, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

Then('User fills form with accountName, url and verify contact details for {string}', async (contactName: string) => {
  const accountName = faker.name.firstName();
  const url = faker.internet.url();

  formPage.inputForAccount = 'Account Name';
  await formPage.type(await formPage.inputforAccountDetails, accountName);
  formPage.inputForAccount = 'URL';
  await formPage.type(await formPage.inputforAccountDetails, url);

  formPage.inputForAccount = 'Account Name';
  expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(accountName);
  formPage.inputForAccount = 'LastName';
  expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(contactName.split(' ')[1]);
  formPage.inputForAccount = 'URL';
  expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(url);

  await formPage.click(await formPage.submit);
  await formPage.waitForPresence(await formPage.name);

  const contactData = (await conn.query(`SELECT AccountId,custom_URL__c FROM Contact WHERE Name='${contactName}'`))
    .records[0];
  expect(contactData.custom_URL__c).toEqual(url);
  const accountId = contactData.AccountId;
  const name = (await conn.query<Fields$Account>(`SELECT Name FROM Account WHERE Id = '${accountId}'`)).records[0].Name;
  expect(name).toEqual(`${accountName}`);
});

After({ tags: '@TEST_PD-29780' }, async () => {
  const formResponseId = await (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records;
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId[0].Id);
  expect(deleteFormResponse.success).toEqual(true);
});
