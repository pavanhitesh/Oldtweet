import { Before, Then, Given } from '@cucumber/cucumber';
import * as faker from 'faker';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$EventApi__Ticket_Type__c, Fields$OrderApi__Item__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29189' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(
  'User updates the SKU field on the item for {string} ticket of event {string}',
  async (ticketType: string, eventName: string) => {
    state.SKU = faker.random.word();
    const updateItemSKU = await conn.tooling
      .executeAnonymous(`OrderApi__Item__c item = [SELECT Id FROM OrderApi__Item__c WHERE EventApi__Event__r.Name = '${eventName}' AND EventApi__Ticket_Type__r.Name = '${ticketType}'];
item.OrderApi__SKU__c = '${state.SKU}';
update item;`);
    expect(updateItemSKU.success).toEqual(true);
  },
);

Given('User updates the {string} ticket capacity for event {string}', async (ticketType: string, eventName: string) => {
  const ticket = (
    await conn.query<Fields$EventApi__Ticket_Type__c>(
      `SELECT Id, EventApi__Quantity_Available__c FROM EventApi__Ticket_Type__c WHERE Name = '${ticketType}' AND EventApi__Event__r.Name = '${eventName}'`,
    )
  ).records[0];
  state.ticketId = ticket.Id;
  const updateTicketCapacity = await conn.tooling
    .executeAnonymous(`EventApi__Ticket_Type__c ticket = [SELECT Id FROM EventApi__Ticket_Type__c WHERE EventApi__Event__r.Name = '${eventName}' AND Name = '${ticketType}'];
    ticket.EventApi__Quantity_Available__c = ${(ticket.EventApi__Quantity_Available__c as number) + 1};
update ticket;`);
  expect(updateTicketCapacity.success).toEqual(true);
});

Then('User verifies the SKU field is not empty on the ticket item', async () => {
  const ticketSKU = (
    await conn.query<Fields$OrderApi__Item__c>(
      `SELECT OrderApi__SKU__c FROM OrderApi__Item__c WHERE EventApi__Ticket_Type__c = '${state.ticketId}'`,
    )
  ).records[0].OrderApi__SKU__c;
  expect(ticketSKU).not.toBeNull();
  expect(ticketSKU).toEqual(state.SKU);
});
