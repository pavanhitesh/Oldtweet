import { Before, Then, When } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';
import { eventPage } from '../../pages/salesforce/event.page';
import { Fields$EventApi__Event__c, Fields$EventApi__Venue__c } from '../../fonteva-schema';

Before({ tags: '@TEST_PD-29209' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
  const venues: Array<{ Id: string }> = (
    await conn.query<Fields$EventApi__Venue__c>(
      `SELECT Id FROM EventApi__Venue__c WHERE Name = 'Primary venue without address'`,
    )
  ).records;
  await Promise.all(venues.map(async (venue) => conn.destroy('EventApi__Venue__c', venue.Id)));
});

When(
  'User creates new primary venue {string} without address for {string} event',
  async (venueName: string, eventName: string) => {
    const eventId = (
      await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE Name = '${eventName}'`)
    ).records[0].Id;
    await browser.sharedStore.set('eventId', eventId);
    await eventPage.createPrimaryVenue(<string>await browser.sharedStore.get('eventId'), venueName);
    await eventPage.waitForPresence(await eventPage.relatedTab);
  },
);

Then(
  'User validates that primary venue {string} without address for {string} event is created',
  async (venueName: string, eventName) => {
    let eventId;
    if (eventName === 'saved event') {
      eventId = await browser.sharedStore.get('eventId');
    } else {
      eventId = (
        await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE Name = '${eventName}'`)
      ).records[0].Id;
    }
    const venues = (
      await conn.query<Fields$EventApi__Venue__c>(
        `SELECT Name FROM EventApi__Venue__c WHERE Name = '${venueName}' AND EventApi__Event__r.Id = '${eventId}'`,
      )
    ).records;
    expect(venues.length).toEqual(1);
  },
);
