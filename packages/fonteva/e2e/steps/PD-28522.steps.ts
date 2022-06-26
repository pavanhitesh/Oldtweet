import * as faker from 'faker';
import { Before, Then } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';
import { portalSelfRegisterPage } from '../../pages/portal/self-register.page';

Before({ tags: '@TEST_PD-29190' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User tries to login as guest and verifies the presence of username and password fields', async () => {
  await eventRegistrationPage.click(await eventRegistrationPage.registerEvent);
  await eventRegistrationPage.click(await eventRegistrationPage.loginBtn);
  await eventRegistrationPage.click(await eventRegistrationPage.notAMemberButton);
  await portalSelfRegisterPage.type(await portalSelfRegisterPage.firstName, faker.name.firstName());
  await portalSelfRegisterPage.type(await portalSelfRegisterPage.lastName, faker.name.lastName());
  await portalSelfRegisterPage.type(await portalSelfRegisterPage.email, faker.internet.email());
  expect(await portalSelfRegisterPage.userName.isDisplayed()).toBe(true);
  expect(await portalSelfRegisterPage.password.isDisplayed()).toBe(true);
  await portalSelfRegisterPage.type(await portalSelfRegisterPage.userName, faker.internet.email());
  await portalSelfRegisterPage.type(await portalSelfRegisterPage.password, `${faker.internet.password(12)}Fon7!`);
  expect(await portalSelfRegisterPage.createAccount.isClickable()).toBe(true);
  await portalSelfRegisterPage.click(await portalSelfRegisterPage.createAccount);
  await eventRegistrationPage.waitForPresence(await eventRegistrationPage.ticketsEventTab);
  expect(await eventRegistrationPage.ticketsEventTab.isDisplayed()).toBe(true);
});
