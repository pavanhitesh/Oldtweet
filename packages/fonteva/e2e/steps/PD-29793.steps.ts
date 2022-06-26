import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$Contact,
  Fields$PagesApi__Field_Response__c,
  Fields$PagesApi__Form_Response__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';

const localSharedData: { [key: string]: string | string } = {};

Then(
  'User verifies {string} and {string} values are populated from the contact {string}',
  async (phoneField: string, cityField: string, contactName: string) => {
    localSharedData.phoneField = phoneField;
    localSharedData.cityField = cityField;
    localSharedData.contactName = contactName;
    formPage.inputForAccount = localSharedData.phoneField;
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    await formPage.sleep(MilliSeconds.XXS);
    const contactData = (
      await conn.query<Fields$Contact>(
        `SELECT HomePhone,MailingCity FROM Contact WHERE Name = '${localSharedData.contactName}'`,
      )
    ).records[0];
    expect(contactData.HomePhone).toEqual(await formPage.getValue(await formPage.inputforAccountDetails));
    formPage.inputForAccount = localSharedData.cityField;
    expect(contactData.MailingCity).toEqual(await formPage.getValue(await formPage.inputforAccountDetails));
  },
);

Then(
  'User submits the form by updating Home Phone and Mailing City for the contact and verifies the response',
  async () => {
    formPage.inputForAccount = localSharedData.phoneField;
    formPage.refreshBrowser();
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    const homePhonenum = faker.datatype.number({ min: 9000000000, max: 9999999999 }) as unknown as string;
    const accountUpdatedCity = faker.address.city();
    await formPage.type(await formPage.inputforAccountDetails, homePhonenum);
    formPage.inputForAccount = localSharedData.cityField;
    await formPage.type(await formPage.inputforAccountDetails, accountUpdatedCity);
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    formPage.refreshBrowser();
    formPage.inputForAccount = localSharedData.phoneField;
    await formPage.sleep(MilliSeconds.XXS);
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(String(homePhonenum));
    formPage.inputForAccount = localSharedData.cityField;
    expect(await formPage.getValue(await formPage.inputforAccountDetails)).toEqual(String(accountUpdatedCity));
    const contactData = (
      await conn.query<Fields$Contact>(
        `SELECT HomePhone,MailingCity FROM Contact WHERE Name = '${localSharedData.contactName}'`,
      )
    ).records[0];
    expect(contactData.HomePhone).toEqual(String(homePhonenum));
    expect(contactData.MailingCity).toEqual(String(accountUpdatedCity));
    localSharedData.formResponseIds = await (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
          'formName',
        )}'`,
      )
    ).records[0].Id;
    const formFieldResponseRecords = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${localSharedData.formResponseIds}'`,
      )
    ).records;
    expect(formFieldResponseRecords[0].PagesApi__Response__c).toEqual(String(homePhonenum));
    expect(formFieldResponseRecords[1].PagesApi__Response__c).toEqual(accountUpdatedCity);
  },
);

After({ tags: '@TEST_PD-29794' }, async () => {
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(localSharedData.formResponseIds);
  expect(deleteFormResponse.success).toEqual(true);
});
