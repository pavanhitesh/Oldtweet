import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';
import { Fields$PagesApi__Form_Response__c, Fields$PagesApi__Field_Response__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

Then(
  'User Submit the form for decimal {string} field mapped to contact {string} and verify response',
  async (fieldname: string, contactName: string) => {
    formPage.inputForAccount = fieldname;
    await formPage.waitForPresence(await formPage.inputforAccountDetails);
    const credScoreData = `${faker.datatype.number({ min: 10, max: 9999 })}.${faker.datatype.number({
      min: 91,
      max: 99,
    })}`;
    await formPage.type(await formPage.inputforAccountDetails, credScoreData);
    await formPage.click(await formPage.submit);
    await formPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    await formPage.sleep(MilliSeconds.XS);
    const creditScore = (await conn.query(`SELECT Credit_Score__c from Contact WHERE Name = '${contactName}'`))
      .records[0].Credit_Score__c;
    expect(String(creditScore)).toEqual(credScoreData);
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
    ).records[0].PagesApi__Response__c;
    expect(String(formResponses)).toEqual(credScoreData);
  },
);

After({ tags: '@TEST_PD-29764' }, async () => {
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(localSharedData.formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
});
