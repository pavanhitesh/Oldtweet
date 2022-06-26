/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';

import { Fields$Account, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const localSharedData: { [key: string]: string | number } = {};

Then(
  'User validate the auto populated fields on form with account details for contact {string}',
  async (contactName: string) => {
    localSharedData.contactName = contactName;
    const accountData = (
      await conn.query<Fields$Account>(
        `SELECT Description,OrderApi__Account_Email__c FROM Account WHERE Id in (SELECT AccountId FROM Contact WHERE Name = '${contactName}')`,
      )
    ).records[0];
    formPage.inputForAccount = `Account Email`;

    expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(
      accountData.OrderApi__Account_Email__c,
    );
    formPage.textAreaInputForAccount = `Account Description`;
    expect(await formPage.getTextUsingJS(await formPage.textAreaInputForAccountDetails)).toEqual(
      accountData.Description,
    );
  },
);

Then('User fills and submits the form and verifies details in Account are updated', async () => {
  localSharedData.description = faker.random.words(2);
  localSharedData.accountName = faker.name.firstName();
  localSharedData.accountEmail = faker.internet.email();
  localSharedData.annualRevenue = faker.datatype.number(5);

  formPage.inputForAccount = `Account Name`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountName);
  formPage.textAreaInputForAccount = `Account Description`;
  await formPage.type(await formPage.textAreaInputForAccountDetails, localSharedData.description);
  formPage.inputForAccount = `Account Email`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountEmail);
  formPage.inputForAccount = `Annual Revenue`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.annualRevenue);

  await formPage.click(await formPage.submit);

  await formPage.waitForPresence(await formPage.name);

  await formPage.sleep(MilliSeconds.XXS);
  const accountData = (
    await conn.query<Fields$Account>(
      `SELECT Name,Description,AnnualRevenue,OrderApi__Account_Email__C FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Name = '${localSharedData.contactName}')`,
    )
  ).records[0];

  expect(accountData.Description).toEqual(localSharedData.description);
  expect(accountData.Name).toEqual(localSharedData.accountName);
  expect((accountData.OrderApi__Account_Email__c as string).toLowerCase).toEqual(
    (localSharedData.accountEmail as string).toLowerCase,
  );
  expect(accountData.AnnualRevenue).toEqual(localSharedData.annualRevenue);
});

After({ tags: '@TEST_PD-29567' }, async () => {
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
