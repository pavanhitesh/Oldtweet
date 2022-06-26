import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { format } from 'date-fns';
import { Fields$PagesApi__Form_Response__c, Fields$Contact, Fields$Account } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string } = {};

Then('User fills the data, submits the form and validates the contact record', async () => {
  localSharedData.accountEmail = faker.internet.email();
  localSharedData.accountName = faker.name.firstName();
  localSharedData.lastName = faker.name.lastName();
  formPage.dateTime = 'DateTime';
  await formPage.waitForPresence(await formPage.dateTimeDetails);
  formPage.inputForAccount = 'AccountName';
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountName);
  const birthDate = await formPage.getDate('MM/dd/yyyy', 0, 0, -22);
  formPage.dateTime = 'DateTime';
  await formPage.type(await formPage.dateTimeDetails, format(new Date(), 'MMM dd, yyyy'));
  formPage.inputForAccount = 'Email';
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountEmail);
  formPage.birthDate = 'Birthdate';
  await formPage.type(await formPage.birthDateDetails, birthDate);
  formPage.inputForAccount = 'LastName';
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.lastName);
  await formPage.click(await formPage.submit);
  await formPage.waitForPresence(await formPage.name);
  expect(await formPage.isDisplayed(await formPage.name)).toEqual(true);
  await formPage.sleep(MilliSeconds.XXXS);
  const contactData = (
    await conn.query<Fields$Contact>(
      `SELECT AccountId, LastName, Birthdate, Email, LastModifiedDate FROM Contact WHERE Email = '${localSharedData.accountEmail}'`,
    )
  ).records[0];
  expect(contactData.LastModifiedDate).toContain(format(new Date(), 'yyyy-MM-dd'));
  expect(contactData.Email).toEqual(localSharedData.accountEmail.toLowerCase());
  expect(contactData.Birthdate).toEqual(format(new Date(birthDate), 'yyyy-MM-dd'));
  expect(contactData.LastName).toEqual(localSharedData.lastName);
  const accountName = (
    await conn.query<Fields$Account>(`SELECT Name FROM Account WHERE Id = '${contactData.AccountId as string}'`)
  ).records[0].Name;
  expect(accountName).toEqual(`${localSharedData.accountName}`);
});

After({ tags: '@TEST_PD-29598' }, async () => {
  const formResponseId = await (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records[0].Id;
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
  const deleteQuery = `DELETE [SELECT Id FROM Contact WHERE Name = '${localSharedData.lastName}'];`;
  const deleteContact = await conn.tooling.executeAnonymous(deleteQuery);
  expect(deleteContact.success).toEqual(true);
});
