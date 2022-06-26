import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$Contact, Fields$Account, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string | number } = {};

Then('User should able to update form with phone, currency and verify contact summary', async () => {
  localSharedData.accountName = faker.name.firstName();
  localSharedData.phone1 = faker.phone.phoneNumber();
  localSharedData.currency = faker.finance.amount(5);

  formPage.inputForAccount = `Account Name`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountName);
  await formPage.click(await formPage.editEntry);
  formPage.inputForContact = 'Phone';
  await formPage.waitForPresence(await formPage.inputforContactDetails);
  await formPage.type(await formPage.inputforContactDetails, localSharedData.phone1);
  formPage.inputForContact = 'Currency';
  await formPage.type(await formPage.inputforContactDetails, localSharedData.currency);
  await formPage.click(await formPage.saveEntry);
  await formPage.waitForPresence(await formPage.name);

  formPage.contactSummary = 'Phone';
  expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(localSharedData.phone1);
  formPage.contactSummary = 'Currency';
  expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(localSharedData.currency);

  await formPage.click(await formPage.submit);
  await formPage.waitForPresence(await formPage.name);
});

Then('User should verify contact details for {string}', async (contactName: string) => {
  localSharedData.contactName = contactName;
  const resultSet = (
    await conn.query<Fields$Contact>(
      `SELECT AccountId,HomePhone,DonorApi__Gifts_Outstanding__c FROM Contact WHERE Name='${localSharedData.contactName}'`,
    )
  ).records[0];
  expect(String(resultSet.HomePhone)).toEqual(localSharedData.phone1);
  expect(String(resultSet.DonorApi__Gifts_Outstanding__c)).toEqual(localSharedData.currency);
  const accountId = resultSet.AccountId;
  const accountName = (await conn.query<Fields$Account>(`SELECT Name FROM Account WHERE Id = '${accountId}'`))
    .records[0].Name;
  expect(accountName).toEqual(`${localSharedData.accountName}`);
});

Then(
  'User fills form with lastName, phone, {string}, {string}, {string}, currency, decimal, checkbox and verify contact summary',
  async (multipicklist1: string, multipicklist2: string, picklist: string) => {
    localSharedData.multipicklist1 = multipicklist1;
    localSharedData.multipicklist2 = multipicklist2;
    localSharedData.picklist = picklist;
    localSharedData.accountName = faker.name.firstName();
    localSharedData.lastName = faker.name.lastName();
    localSharedData.phone = faker.phone.phoneNumber();
    localSharedData.currency = faker.finance.amount(5);
    localSharedData.decimal = faker.datatype.number(3);

    formPage.inputForAccount = `Account Name`;
    await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountName);
    await formPage.click(await formPage.deleteEntry);
    await formPage.waitForPresence(await formPage.name);
    await formPage.click(await formPage.addNewEntryButton);

    formPage.inputForContact = 'LastName';
    await formPage.waitForPresence(await formPage.inputforContactDetails);
    await formPage.type(await formPage.inputforContactDetails, localSharedData.lastName);
    formPage.inputForContact = 'Phone';
    await formPage.type(await formPage.inputforContactDetails, localSharedData.phone);
    await formPage.click(await formPage.multipicklist);
    formPage.multiPickListValue = localSharedData.multipicklist1;
    await formPage.click(await formPage.multiPickListOption);
    await formPage.click(await formPage.multipicklist);
    formPage.multiPickListValue = localSharedData.multipicklist2;
    await formPage.click(await formPage.multiPickListOption);
    await formPage.selectByVisibleText(await formPage.picklist, localSharedData.picklist);
    formPage.inputForContact = 'Currency';
    await formPage.type(await formPage.inputforContactDetails, localSharedData.currency);
    formPage.inputForContact = 'Decimal';
    await formPage.type(await formPage.inputforContactDetails, localSharedData.decimal);
    await formPage.click(await formPage.checkbox);
    await formPage.click(await formPage.addEntryButton);
    await formPage.waitForPresence(await formPage.name);

    formPage.contactSummary = 'LastName';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(localSharedData.lastName);
    formPage.contactSummary = 'Phone';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(localSharedData.phone);
    formPage.contactSummary = 'Multipicklist';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(
      `${localSharedData.multipicklist1}`.concat(`,`, `${localSharedData.multipicklist2}`),
    );
    formPage.contactSummary = 'Picklist';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(localSharedData.picklist);
    formPage.contactSummary = 'Currency';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(localSharedData.currency);
    formPage.contactSummary = 'Checkbox';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(`true`);
    formPage.contactSummary = 'Decimal';
    expect(await formPage.getText(await formPage.contactSummaryDetails)).toEqual(String(localSharedData.decimal));

    await formPage.click(await formPage.submit);
    expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
  },
);

Then('User should verify contact details', async () => {
  const resultSet = (
    await conn.query<Fields$Contact>(
      `SELECT AccountId,HomePhone,Multi_Select_Picklist__c,DonorApi__Default_Greeting_Type__c,DonorApi__Gifts_Outstanding__c,DonorApi__Active_Recurring_Gift__c,OrderApi__Annual_Engagement_Score__c FROM Contact WHERE Name='${localSharedData.lastName}'`,
    )
  ).records[0];
  expect(String(resultSet.HomePhone)).toEqual(localSharedData.phone);
  expect(resultSet.Multi_Select_Picklist__c).toEqual(
    `${localSharedData.multipicklist1}`.concat(`;`, `${localSharedData.multipicklist2}`),
  );
  expect(resultSet.DonorApi__Default_Greeting_Type__c).toEqual(localSharedData.picklist);
  expect(String(resultSet.DonorApi__Gifts_Outstanding__c)).toEqual(localSharedData.currency);
  expect(resultSet.OrderApi__Annual_Engagement_Score__c).toEqual(localSharedData.decimal);
  expect(resultSet.DonorApi__Active_Recurring_Gift__c).toEqual(true);
  const accountId = resultSet.AccountId;
  const accountName = (await conn.query<Fields$Account>(`SELECT Name FROM Account WHERE Id = '${accountId}'`))
    .records[0].Name;
  expect(accountName).toEqual(`${localSharedData.accountName}`);
});

After({ tags: '@TEST_PD-29565' }, async () => {
  const formResponseId = await (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records;
  const deleteFormResponse1 = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId[0].Id);
  expect(deleteFormResponse1.success).toEqual(true);
  const deleteFormResponse2 = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId[1].Id);
  expect(deleteFormResponse2.success).toEqual(true);
  const deleteQuery = `DELETE [SELECT Id FROM Contact WHERE Name = '${localSharedData.lastName}'];`;
  await conn.tooling.executeAnonymous(deleteQuery);
});
