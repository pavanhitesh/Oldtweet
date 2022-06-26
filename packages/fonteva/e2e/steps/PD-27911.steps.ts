import { After, Before, Then } from '@cucumber/cucumber';
import { addDays, format } from 'date-fns';
import { receiptPage } from '../../pages/portal/receipt.page';
import { profilePage } from '../../pages/portal/profile.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { Fields$OrderApi__Receipt__c } from '../../fonteva-schema';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { conn } from '../../shared/helpers/force.helper';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

const state: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-29108' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User verifies the end date on sales order line for {string} checkout', async (checkoutPage: string) => {
  await subscriptionPage.sleep(MilliSeconds.XXS); // subscription Creation
  if (checkoutPage === 'portal') {
    state.salesOrderId = (await browser.sharedStore.get('portalSO')) as string;
  } else {
    state.salesOrderId = (
      await conn.query<Fields$OrderApi__Receipt__c>(
        `SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
          'receiptNameROE',
        )}'`,
      )
    ).records[0].OrderApi__Sales_Order__c as string;
  }
  const subscriptionInfo = await conn.query(
    `SELECT OrderApi__Subscription__r.Id, OrderApi__Sales_Order_Line__r.OrderApi__Subscription_Start_Date__c, OrderApi__Sales_Order_Line__r.OrderApi__End_Date__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${state.salesOrderId}'`,
  );
  state.subscriptionId = subscriptionInfo.records[0].OrderApi__Subscription__r.Id;
  const subscriptionStartDate =
    subscriptionInfo.records[0].OrderApi__Sales_Order_Line__r.OrderApi__Subscription_Start_Date__c;
  const solEndDate = subscriptionInfo.records[0].OrderApi__Sales_Order_Line__r.OrderApi__End_Date__c;
  const addDaysToSubStartDate = addDays(new Date(subscriptionStartDate), 364);
  const newSolEndDate = new Date(
    addDaysToSubStartDate.valueOf() + addDaysToSubStartDate.getTimezoneOffset() * 60 * 1000,
  );
  const checksolEndDate = format(newSolEndDate, 'yyyy-MM-dd');
  expect(checksolEndDate).toEqual(solEndDate as string);
});

Then('User navigate to profile and select the {string} page in LT Portal', async (page: string) => {
  await receiptPage.click(await receiptPage.profileMenu);
  await receiptPage.click(await receiptPage.profile);
  profilePage.selectProfilePage = page;
  await profilePage.click(await profilePage.navigateToProfilePage);
  await profilePage.waitForPresence(await profilePage.pageheader);
  expect(await profilePage.isDisplayed(await profilePage.pageheader)).toEqual(true);
});

After({ tags: '@TEST_PD-29108' }, async () => {
  await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
});

After({ tags: '@TEST_PD-29176' }, async () => {
  await conn.sobject('OrderApi__Sales_Order__c').destroy(state.salesOrderId as string);
  await conn.sobject('OrderApi__Subscription__c').destroy(state.subscriptionId as string);
});
