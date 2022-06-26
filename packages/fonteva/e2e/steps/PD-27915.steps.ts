import { When, DataTable, Then } from '@cucumber/cucumber';
import { Fields$Contact, Fields$EventApi__Ticket_Type__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { agendaPage } from '../../pages/portal/agenda.page';
import { attendeeModalPage } from '../../pages/portal/attendee-modal.page';
import { recommendedItemsPage } from '../../pages/portal/recommend-items.page';

When(
  'User updates the Attendee list for the ticket {string} as below:',
  async (ticketName: string, attendeeNames: DataTable) => {
    const attendeeList = attendeeNames.hashes();
    const ticketId = (
      await conn.query<Fields$EventApi__Ticket_Type__c>(
        `SELECT Id FROM EventApi__Ticket_Type__c WHERE Name = '${ticketName}' and EventApi__Event__c = '${await browser.sharedStore.get(
          'eventId',
        )}'`,
      )
    ).records[0].Id;
    let index = 1;
    await attendeeList.reduce(async (memo, guestAttendee) => {
      await memo;
      await attendeeModalPage.click(await attendeeModalPage.continue);
      attendeeModalPage.attendeeSection = ticketId;
      attendeeModalPage.attendeeNumber = index;
      await attendeeModalPage.click(await attendeeModalPage.attendeeToSelect);
      expect(await attendeeModalPage.getAttributeValue(await attendeeModalPage.attendeeToSelect, 'class')).toContain(
        'active',
      );
      await attendeeModalPage.click(await attendeeModalPage.attendeeSearchbox);
      await attendeeModalPage.slowTypeFlex(await attendeeModalPage.attendeeSearchInput, guestAttendee.GuestName);
      const attendeeContactId = (
        await conn.query<Fields$Contact>(`SELECT Id FROM Contact WHERE Name = '${guestAttendee.GuestName}'`)
      ).records[0].Id;
      attendeeModalPage.attendeeIdSuggestion = attendeeContactId;
      await attendeeModalPage.click(await attendeeModalPage.attendeeSuggestionOption);
      await attendeeModalPage.waitForClickable(await attendeeModalPage.continue);
      expect(await attendeeModalPage.getText(await attendeeModalPage.attendeeToSelect)).toEqual(
        guestAttendee.GuestName,
      );
      index += 1;
    }, undefined);
  },
);

When(`User navigates to agenda page`, async () => {
  await attendeeModalPage.click(await attendeeModalPage.continue);
  await agendaPage.waitForPresence(await agendaPage.continue);
  expect(await agendaPage.isDisplayed(await agendaPage.continue)).toBe(true);
});

Then(`User verifies packageitems can be added for each of the below attendees:`, async (attendeesList: DataTable) => {
  const attendeeOrderData = attendeesList.hashes();
  await attendeeOrderData.reduce(async (memo, attendeeInfo) => {
    await memo;
    await recommendedItemsPage.selectAttendee(attendeeInfo.AttendeeName);
    expect(
      await browser.execute(
        `return arguments[0].label`,
        await (await recommendedItemsPage.attendeePicklistDropdown).$(`select option:checked`),
      ),
    ).toEqual(attendeeInfo.AttendeeName);
    await recommendedItemsPage.selectRecommendedItem(attendeeInfo.packageItemName);
    await recommendedItemsPage.waitForPresence(await recommendedItemsPage.addToOrder);
    await recommendedItemsPage.click(await recommendedItemsPage.addToOrder);
    await recommendedItemsPage.waitForAbsence(await recommendedItemsPage.addToOrder);
    recommendedItemsPage.packageItemforAttendee = attendeeInfo.AttendeeName;
    await recommendedItemsPage.waitForPresence(await recommendedItemsPage.attendeeAddedPackageItem);
    expect(
      (await recommendedItemsPage.getText(await recommendedItemsPage.attendeeAddedPackageItem)).replace('Edit', ''),
    ).toBe(attendeeInfo.packageItemName);
  }, undefined);
});
