import { Before, Then, After } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29440' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User verifies badge {string} is added and assignment is created for contact {string}',
  async (badgeName: string, contactLastName: string) => {
    localSharedData.contactName = contactLastName;

    const assignmentRecords = (
      await conn.query(
        `SELECT Id FROM OrderApi__Assignment__c WHERE OrderApi__Subscription__c ='${await browser.sharedStore.get(
          'subscriptionId',
        )}' and OrderApi__Contact__r.Name = '${contactLastName}'`,
      )
    ).records;

    expect(assignmentRecords.length).toBeGreaterThanOrEqual(1);
    localSharedData.assignmentId = assignmentRecords[0].Id as string;

    const badge = (
      await conn.query(
        `SELECT OrderApi__Badge_Type__r.Name, OrderApi__Contact__r.Name, Id FROM OrderApi__Badge__c 
      WHERE OrderApi__Assignment__c = '${localSharedData.assignmentId}'`,
      )
    ).records;

    expect(badge.length).toEqual(1);
    expect(badge[0].OrderApi__Badge_Type__r.Name).toEqual(badgeName);
    expect(badge[0].OrderApi__Contact__r.Name).toEqual(contactLastName);

    localSharedData.badgeId = badge[0].Id as string;
  },
);

After({ tags: '@TEST_PD-29440' }, async () => {
  const deleteSubscription = await conn
    .sobject('OrderApi__Subscription__c')
    .destroy((await browser.sharedStore.get('subscriptionId')) as string);
  expect(deleteSubscription.success).toEqual(true);

  const deleteBadge = await conn.tooling.executeAnonymous(
    `DELETE [SELECT Id From OrderApi__Badge__c WHERE Id = '${localSharedData.badgeId}'];`,
  );
  expect(deleteBadge.success).toEqual(true);

  const deleteAssignment = await conn.tooling.executeAnonymous(
    `DELETE [SELECT Id From OrderApi__Assignment__c WHERE Id = '${localSharedData.assignmentId}'];`,
  );
  expect(deleteAssignment.success).toEqual(true);

  const deleteContact = await conn.tooling.executeAnonymous(
    `DELETE [SELECT Id FROM Contact WHERE LastName = '${localSharedData.contactLastName}'];`,
  );
  expect(deleteContact.success).toEqual(true);
});
