import { Then } from '@cucumber/cucumber';
import { Fields$OrderApi__Price_Rule__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { agendaPage } from '../../pages/portal/agenda.page';

Then(
  'User selects {string} sessions on agenda page and validate the in-cart pricing is applied',
  async (session: string) => {
    agendaPage.scheduleItemName = session;
    await agendaPage.slowTypeFlex(await agendaPage.scheduleItemSearch, session);
    await agendaPage.click(await agendaPage.addScheduleItemButton);
    await agendaPage.waitForPresence(await agendaPage.scheduleItemPriceDisplayedInSummary);
    const configuredPrice = (
      await conn.query<Fields$OrderApi__Price_Rule__c>(
        `SELECT OrderApi__Price__c FROM OrderApi__Price_Rule__c Where OrderApi__Item__r.Name = '${session}' and Name = '${session}'`,
      )
    ).records[0].OrderApi__Price__c;
    expect(await agendaPage.getText(await agendaPage.scheduleItemPriceDisplayedInSummary)).toEqual(
      `$${configuredPrice}.00`,
    );
  },
);
