import { Given, Before, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';

Before({ tags: '@TEST_PD-27604' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(
  'User can update the assignment visibility to {string} for {string} account',
  async (status: boolean, name: string) => {
    const apexBody = `Account visibility = [Select Id from Account Where Name = '${name}'];
  visibility.OrderApi__Restrict_Assignment_Visibility__c = ${status};
  update visibility;`;
    await conn.tooling.executeAnonymous(apexBody);
  },
);

Then('User should not see other contacts from account on assign members page', async () => {
  await assignMemberPage.waitForPresence(await assignMemberPage.AddToCart);
  await assignMemberPage.waitForPresence(await assignMemberPage.addMember);
  expect(await assignMemberPage.getAssignMembersCount()).toEqual(1);
});
