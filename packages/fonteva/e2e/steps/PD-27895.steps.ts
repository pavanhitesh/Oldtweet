import { After, Before, When } from '@cucumber/cucumber';
import { subscriptionToRenewPage } from '../../pages/portal/subscriptions-to-renew.page';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { loginPage } from '../../pages/salesforce/login.page';
import { conn } from '../../shared/helpers/force.helper';

Before({ tags: '@TEST_PD-29002' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29002' }, async () => {
  const salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);

  const subscriptionDeleted = await conn.destroy(
    'OrderApi__Subscription__c',
    (await browser.sharedStore.get('subscriptionId')) as string,
  );
  expect(subscriptionDeleted.success).toEqual(true);
});

When(`User changes the role for {string} and verfies role is updated`, async (contactName: string) => {
  subscriptionToRenewPage.assignMembertoSelect = contactName;
  subscriptionToRenewPage.assignMemberRole_Name = contactName;
  expect(await subscriptionToRenewPage.isSelected(await subscriptionToRenewPage.assignMemberSelectCheckbox)).toBe(true);
  const selectedRole = await subscriptionToRenewPage.getSelectedOption(
    await subscriptionToRenewPage.assignMemberRoleDropDown,
  );
  const availableRoles = await subscriptionToRenewPage.getSelectOptions(
    await subscriptionToRenewPage.assignMemberRoleDropDown,
  );
  let newRoleSelected;
  for (let i = 0; i < availableRoles.length; i += 1) {
    if (availableRoles[i] !== selectedRole) {
      newRoleSelected = availableRoles[i];
      await subscriptionToRenewPage.selectByAttribute(
        await subscriptionToRenewPage.assignMemberRoleDropDown,
        'label',
        availableRoles[i],
      );
      break;
    }
  }
  await subscriptionToRenewPage.waitForPresence(await subscriptionToRenewPage.assignMemberRoleDropDown);
  expect(
    await browser.execute(
      `return arguments[0].label`,
      await (await subscriptionToRenewPage.assignMemberRoleSection).$(`select option:checked`),
    ),
  ).toEqual(newRoleSelected);
});
