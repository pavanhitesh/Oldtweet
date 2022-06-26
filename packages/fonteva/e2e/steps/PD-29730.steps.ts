import { After, Then } from '@cucumber/cucumber';
import { Fields$Contact, Fields$PagesApi__Form_Response__c } from '../../fonteva-schema';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { conn } from '../../shared/helpers/force.helper';

Then(
  'Then User submits the form by updating donotcall dynamic variable and verifies the contact {string}',
  async (contactName: string) => {
    const updateDonotCallFlag = await conn.tooling.executeAnonymous(`Contact
    contactRecord = [SELECT DoNotCall FROM Contact WHERE Name='${contactName}']; 
    contactRecord.DoNotCall =  false ;
    update contactRecord;`);
    expect(updateDonotCallFlag.success).toEqual(true);

    await formPage.waitForPresence(await formPage.submit);
    await formPage.navigateTo((await formPage.getUrl()).concat('&donotcall=true'));
    await formPage.click(await formPage.submit);
    await formPage.waitForPresence(await formPage.submit);
    await formPage.sleep(MilliSeconds.S);
    const donotCallEnabled = (
      await conn.query<Fields$Contact>(`SELECT DoNotCall from Contact WHERE Name = '${contactName}'`)
    ).records[0].DoNotCall;
    expect(donotCallEnabled).toEqual(true);
  },
);

After({ tags: '@TEST_PD-29722' }, async () => {
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
