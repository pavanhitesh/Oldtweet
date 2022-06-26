import { Before, Then, After } from '@cucumber/cucumber';
import { add, format } from 'date-fns';
import { conn } from '../../shared/helpers/force.helper';
import {
  Fields$OrderApi__Subscription__c,
  Fields$OrderApi__Renewal__c,
  Fields$OrderApi__Assignment__c,
} from '../../fonteva-schema';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { loginPage } from '../../pages/salesforce/login.page';

const state: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-27680' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-27680' }, async () => {
  const deleteRenewalSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy(state.renewalSubscription as string);
  expect(deleteRenewalSubscription.success).toEqual(true);
  const deleteRenewalSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteRenewalSO.success).toEqual(true);
  const deleteOriginalSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(state.originalSubcription);
  expect(deleteOriginalSubscription.success).toEqual(true);
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('salesOrderId')) as string);
  expect(deleteSO.success).toEqual(true);
});

Then(
  'User should be able to verify the {string} assignments created, term start and end dates on the backend',
  async (assignments: string) => {
    await loginPage.sleep(MilliSeconds.XS); // need this delay for subscription record creation
    const subscriptionRecord = (
      await conn.query<Fields$OrderApi__Subscription__c>(
        `SELECT Id, OrderApi__Last_Renewed_Date__c, OrderApi__Term_Start_Date__c, OrderApi__Term_End_Date__c, OrderApi__Days_To_Lapse__c 
         FROM OrderApi__Subscription__c WHERE Id IN (SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE 
         OrderApi__Sales_Order__c = '${await browser.sharedStore.get('salesOrderId')}')`,
      )
    ).records[0];
    state.originalSubcription = subscriptionRecord.Id;
    const date = new Date();
    const termStartDate = format(date, 'yyyy-MM-dd');
    expect(subscriptionRecord.OrderApi__Last_Renewed_Date__c).toEqual(termStartDate);
    expect(subscriptionRecord.OrderApi__Term_Start_Date__c).toEqual(termStartDate);
    const termEndDate = format(
      add(new Date(), { days: subscriptionRecord.OrderApi__Days_To_Lapse__c as number }),
      'yyyy-MM-dd',
    );
    expect(subscriptionRecord.OrderApi__Term_End_Date__c).toEqual(termEndDate);
    const renewTerm = (
      await conn.query<Fields$OrderApi__Renewal__c>(
        `SELECT OrderApi__Days_To_Lapse__c, OrderApi__Term_Start_Date__c, OrderApi__Term_End_Date__c, OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
          'portalSO',
        )}'`,
      )
    ).records[0];
    state.renewalSubscription = renewTerm.OrderApi__Subscription__c;
    const renewTermStartDate = format(add(new Date(termEndDate), { days: 2 }), 'yyyy-MM-dd');
    expect(renewTerm.OrderApi__Term_Start_Date__c).toEqual(renewTermStartDate);
    const renewTermEndDate = format(
      add(new Date(), { days: renewTerm.OrderApi__Days_To_Lapse__c as number }),
      'yyyy-MM-dd',
    );
    expect(renewTerm.OrderApi__Term_End_Date__c).toEqual(renewTermEndDate);
    const renewAssignments = (
      await conn.query<Fields$OrderApi__Assignment__c>(
        `SELECT Id FROM OrderApi__Assignment__c WHERE OrderApi__Subscription__c = '${renewTerm.OrderApi__Subscription__c}'`,
      )
    ).records;
    expect(renewAssignments.length).toEqual(assignments);
  },
);
