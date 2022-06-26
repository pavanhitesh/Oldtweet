import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$Account,
  Fields$PagesApi__Field_Response__c,
  Fields$PagesApi__Form_Response__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';

const localSharedData: { [key: string]: string | string } = {};

Then('User verifies Account Name and Billing city values are populated for the contact', async () => {
  formPage.inputForAccount = localSharedData.accountName;
  expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(localSharedData.accountUpdateName);
  formPage.inputForAccount = localSharedData.billingCity;
  expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(
    localSharedData.accountUpdatedBillingCity,
  );
  const accountData = (
    await conn.query<Fields$Account>(
      `SELECT Name,BillingCity FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Name = '${localSharedData.contactName}')`,
    )
  ).records[0];
  expect(accountData.Name).toEqual(localSharedData.formUpdatedAccount);
  expect(accountData.BillingCity).toEqual(localSharedData.formUpdatedCity);
});

Then(
  'User submits the form by updating {string} and {string} for the account of {string} and verifies the account record.',
  async (accountName: string, billingCity: string, contactName: string) => {
    localSharedData.accountName = accountName;
    localSharedData.billingCity = billingCity;
    localSharedData.accountUpdateName = `delete_account_${faker.finance.accountName()}_${faker.address.streetName()}`;
    localSharedData.accountUpdatedBillingCity = faker.address.city();
    localSharedData.contactName = contactName;
    formPage.inputForAccount = accountName;
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountUpdateName);
    formPage.inputForAccount = billingCity;
    await formPage.type(await formPage.inputforAccountDetails, localSharedData.accountUpdatedBillingCity);
    await formPage.click(await formPage.submit);
    await formPage.refreshBrowser();
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.XS);
    const accountData = (
      await conn.query<Fields$Account>(
        `SELECT BillingCity FROM Account WHERE Name = '${localSharedData.accountUpdateName}'`,
      )
    ).records[0];
    expect(accountData.BillingCity).toEqual(localSharedData.accountUpdatedBillingCity);

    localSharedData.formResponseId = await (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
          'formName',
        )}'`,
      )
    ).records[0].Id;
    const formResponses = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${localSharedData.formResponseId}'`,
      )
    ).records;
    localSharedData.formUpdatedAccount = formResponses[0].PagesApi__Response__c as string;
    localSharedData.formUpdatedCity = formResponses[1].PagesApi__Response__c as string;
    expect(localSharedData.formUpdatedAccount).toEqual(String(localSharedData.accountUpdateName));
    expect(localSharedData.formUpdatedCity).toEqual(String(localSharedData.accountUpdatedBillingCity));
  },
);

After({ tags: '@TEST_PD-29718' }, async () => {
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(localSharedData.formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
});
