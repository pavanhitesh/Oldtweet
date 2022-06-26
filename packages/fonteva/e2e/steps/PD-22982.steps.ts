import { After, Before, Given, Then } from '@cucumber/cucumber';
import { format } from 'date-fns';
import * as faker from 'faker';
import { Fields$EventApi__Speaker__c } from 'packages/fonteva/fonteva-schema';
import { eventBuilderPage } from '../../pages/salesforce/event-builder.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29457' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(`User navigates to events tabs`, async () => {
  await eventBuilderPage.open(`/lightning/o/EventApi__Event__c/list`);
  await eventBuilderPage.waitForPresence(await eventBuilderPage.newEvent);
  expect(await eventBuilderPage.isDisplayed(await eventBuilderPage.newEvent)).toBe(true);
});

Then(`User clones the event with {string} event`, async (cloneEvent: string) => {
  localSharedData.cloneEventName = cloneEvent;
  await eventBuilderPage.click(await eventBuilderPage.newEvent);
  await eventBuilderPage.waitForPresence(await eventBuilderPage.cloneEventHeader);
  expect(await eventBuilderPage.isDisplayed(await eventBuilderPage.cloneEventHeader)).toBe(true);
  localSharedData.newEventName = faker.name.firstName();
  await eventBuilderPage.slowTypeFlex(await eventBuilderPage.inputEventName, localSharedData.newEventName);
  const date = new Date();
  const eventStartDate = format(date, 'MM/dd/yyyy');
  await eventBuilderPage.slowTypeFlex(await eventBuilderPage.eventStartDate, eventStartDate);
  await eventBuilderPage.selectEventCategory('Lightning Event Category');
  await eventBuilderPage.slowTypeFlex(await eventBuilderPage.searchEventName, cloneEvent);
  await browser.keys('Enter');
  await eventBuilderPage.click(await eventBuilderPage.continueClone);
  await eventBuilderPage.click(await eventBuilderPage.finishClone);
  await eventBuilderPage.waitForPresence(await eventBuilderPage.eventName);
  expect(await eventBuilderPage.getText(await eventBuilderPage.eventName)).toEqual(localSharedData.newEventName);
});

Then(`User verifies all the speakers are cloned`, async () => {
  const newEventTotalSpeakers = await conn.query<Fields$EventApi__Speaker__c>(
    `SELECT Id, EventApi__Event__c from EventApi__Speaker__c where EventApi__Event__r.Name = '${localSharedData.newEventName}'`,
  );
  const cloneEvenTotalSpeakers = await conn.query<Fields$EventApi__Speaker__c>(
    `SELECT Id from EventApi__Speaker__c where EventApi__Event__r.Name = '${localSharedData.cloneEventName}'`,
  );
  expect(cloneEvenTotalSpeakers.records.length).toEqual(newEventTotalSpeakers.records.length);
  localSharedData.eventId = newEventTotalSpeakers.records[0].EventApi__Event__c as string;
});

After({ tags: '@TEST_PD-29457' }, async () => {
  const deleteEvent = await conn.sobject('EventApi__Event__c').destroy(localSharedData.eventId as string);
  expect(deleteEvent.success).toEqual(true);
});
