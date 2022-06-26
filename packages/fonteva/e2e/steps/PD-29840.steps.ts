import { After, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { formPage } from '../../pages/portal/form.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import {
  Fields$EventApi__Event__c,
  Fields$EventApi__Speaker__c,
  Fields$PagesApi__Field_Response__c,
  Fields$PagesApi__Form_Response__c,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

Then('User links the form with the event {string} using url parameter.', async (parentEventName: string) => {
  localSharedData.parentEventName = parentEventName;
  const eventId = (
    await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE
EventApi__Display_Name__c='${localSharedData.parentEventName}'`)
  ).records[0].Id;
  await formPage.navigateTo((await formPage.getUrl()).concat(`&eventId=${eventId}`));
  await formPage.waitForPresence(await formPage.submit);
  await formPage.sleep(MilliSeconds.S);
  expect(await formPage.getUrl()).toContain(`&eventId=${eventId}`);
});

Then(
  'Then User submits the form with {string} and {string} and verifies the form response',
  async (speakerName: string, speakerCompany: string) => {
    localSharedData.speakerName = `${faker.name.firstName()} ${faker.name.lastName()}`;
    localSharedData.speakerCompany = faker.company.companyName();
    formPage.inputForAccount = speakerName;
    await formPage.type(await formPage.inputforAccountDetails, localSharedData.speakerName);
    formPage.inputForAccount = speakerCompany;
    await formPage.type(await formPage.inputforAccountDetails, localSharedData.speakerCompany);
    await formPage.click(await formPage.submit);
    await formPage.sleep(MilliSeconds.S);

    localSharedData.formResponseId = await (
      await conn.query<Fields$PagesApi__Form_Response__c>(
        `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
          'formName',
        )}'`,
      )
    ).records[0].Id;
    const responseRecords = (
      await conn.query<Fields$PagesApi__Field_Response__c>(
        `SELECT PagesApi__Response__c FROM PagesApi__Field_Response__c WHERE PagesApi__Form_Response__c = '${localSharedData.formResponseId}'`,
      )
    ).records;
    const formSpeakerName = responseRecords[0].PagesApi__Response__c as string;
    const formSpeakerCompany = responseRecords[1].PagesApi__Response__c as string;
    expect(formSpeakerName).toEqual(String(localSharedData.speakerName));
    expect(formSpeakerCompany).toEqual(String(localSharedData.speakerCompany));
  },
);

Then('User verifies the speaker information added in the parent event', async () => {
  const parentEventData = (
    await conn.query<Fields$EventApi__Speaker__c>(
      `SELECT Id, Name, EventApi__Company_Name__c FROM EventApi__Speaker__c WHERE EventApi__Event__r.Name = '${localSharedData.parentEventName}'`,
    )
  ).records[0];
  expect(parentEventData.Name).toEqual(localSharedData.speakerName);
  expect(parentEventData.EventApi__Company_Name__c).toEqual(localSharedData.speakerCompany);
  localSharedData.eventSpeakerId = parentEventData.Id as string;
});

After({ tags: '@TEST_PD-29841' }, async () => {
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(localSharedData.formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
  const deleteSpeaker = await conn.sobject('EventApi__Speaker__c').destroy(localSharedData.eventSpeakerId);
  expect(deleteSpeaker.success).toEqual(true);
});
