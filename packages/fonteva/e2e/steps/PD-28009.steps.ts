import { Before, Given, Then } from '@cucumber/cucumber';
import { add, differenceInCalendarDays, format } from 'date-fns';
import { eventBuilderPage } from '../../pages/salesforce/event-builder.page';
import { Fields$EventApi__Event__c } from '../../fonteva-schema';
import { eventPage } from '../../pages/salesforce/event.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-29328' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(`User navigates to event {string} page`, async (eventName: string) => {
  const eventId = (
    await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE
    EventApi__Display_Name__c='${eventName}'`)
  ).records[0].Id;
  await eventPage.open(`/lightning/r/EventApi__Event__c/${eventId}/view`);
  await eventPage.waitForPresence(await eventPage.editBtn);
  expect(await eventPage.isDisplayed(await eventPage.editBtn)).toBe(true);
});

Then(
  `User opens the eventbuilder page, enters the startDate and EndDate manually and verifies duration is calculated correctly`,
  async () => {
    await eventPage.click(await eventPage.editBtn);
    await eventBuilderPage.waitForPresence(await eventBuilderPage.pageHeader);
    expect(await eventBuilderPage.isDisplayed(await eventBuilderPage.pageHeader)).toBe(true);

    await eventBuilderPage.click(await eventBuilderPage.eventInfo);
    await eventBuilderPage.waitForPresence(await eventBuilderPage.eventStartDate);
    expect(await eventBuilderPage.isDisplayed(await eventBuilderPage.eventStartDate)).toBe(true);

    await eventBuilderPage.selectByAttribute(await eventBuilderPage.eventStartHour, 'value', '10');
    await eventBuilderPage.selectByAttribute(await eventBuilderPage.eventStartMinute, 'value', '00');
    await eventBuilderPage.selectByAttribute(await eventBuilderPage.eventStartAMPM, 'value', 'AM');

    await eventBuilderPage.selectByAttribute(await eventBuilderPage.eventEndHour, 'value', '10');
    await eventBuilderPage.selectByAttribute(await eventBuilderPage.eventEndMinute, 'value', '00');
    await eventBuilderPage.selectByAttribute(await eventBuilderPage.eventEndAMPM, 'value', 'AM');

    const eventStartDateVal = format(new Date(), 'MM/dd/yyyy');
    await eventBuilderPage.type(await eventBuilderPage.eventStartDate, eventStartDateVal);

    const eventEndDateVal = format(add(new Date(eventStartDateVal), { days: 2 }), 'MM/dd/yyyy');
    await eventBuilderPage.type(await eventBuilderPage.eventEndDate, eventEndDateVal);

    const eventDurationExpected = differenceInCalendarDays(new Date(eventEndDateVal), new Date(eventStartDateVal));
    expect((await eventBuilderPage.getText(await eventBuilderPage.eventDurationDays)).trim()).toEqual(
      `${eventDurationExpected} days`,
    );
  },
);
