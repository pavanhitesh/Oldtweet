import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$Contact, Fields$Account, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string | number } = {};

Then(
  'User validate the populated field values on form with details of contact {string}',
  async (contactName: string) => {
    localSharedData.contactName = contactName;
    formPage.inputForAccount = `Account Name`;
    expect(await formPage.isDisplayed(await formPage.inputforAccountDetails)).toEqual(true);
    const contactRecord = (
      await conn.query<Fields$Contact>(
        `SELECT AccountId, MailingStreet, Description FROM Contact WHERE Name='${localSharedData.contactName}'`,
      )
    ).records[0];
    const accountData = (
      await conn.query<Fields$Account>(`SELECT Name FROM Account WHERE Id = '${contactRecord.AccountId}'`)
    ).records[0];

    expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(accountData.Name);
    formPage.textAreaInputForAccount = `MailingStreet`;
    expect(await formPage.getTextUsingJS(await formPage.textAreaInputForAccountDetails)).toEqual(
      contactRecord.MailingStreet,
    );
    formPage.textAreaInputForAccount = `contactDescription`;
    expect(await formPage.getTextUsingJS(await formPage.textAreaInputForAccountDetails)).toEqual(
      contactRecord.Description,
    );
  },
);

Then('User updates mailing Street and contact description and submits and Verify updated contact details', async () => {
  localSharedData.accountName = faker.name.firstName();
  localSharedData.mailingStreet = faker.address.streetName();
  localSharedData.description = faker.name.jobDescriptor();
  formPage.inputForAccount = `Account Name`;
  await formPage.waitForPresence(await formPage.inputforAccountDetails);
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountName);
  formPage.textAreaInputForAccount = `MailingStreet`;
  await formPage.type(await formPage.textAreaInputForAccountDetails, localSharedData.mailingStreet);
  formPage.textAreaInputForAccount = `contactDescription`;
  await formPage.type(await formPage.textAreaInputForAccountDetails, localSharedData.description);
  await formPage.waitForPresence(await formPage.submit);
  await formPage.click(await formPage.submit);
  await formPage.waitForClickable(await formPage.submit);
  const UpsertcontactRecord = (
    await conn.query<Fields$Contact>(
      `SELECT AccountId, MailingStreet, Description FROM Contact WHERE Name='${localSharedData.contactName}'`,
    )
  ).records[0];
  const upsertAccountData = (
    await conn.query<Fields$Account>(`SELECT Name FROM Account WHERE Id = '${UpsertcontactRecord.AccountId}'`)
  ).records[0];
  expect(UpsertcontactRecord.MailingStreet).toEqual(localSharedData.mailingStreet);
  expect(UpsertcontactRecord.Description).toEqual(localSharedData.description);
  expect(upsertAccountData.Name).toEqual(localSharedData.accountName);
});

After({ tags: '@TEST_PD-29629' }, async () => {
  const formResponseId = await (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records[0].Id;
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
});
