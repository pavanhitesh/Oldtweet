import { Before, Then } from '@cucumber/cucumber';
import { commonPage } from '../../pages/salesforce/_common.page';
import { loginPage } from '../../pages/salesforce/login.page';
import * as data from '../data/PD-28729.json';

Before({ tags: '@TEST_PD-28729' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then('User clones the community site and verifies the validation message', async () => {
  await commonPage.click(await commonPage.clone);
  await commonPage.click(await commonPage.save);
  expect(await commonPage.validationMessage.getText()).toEqual(data.validationMessage);
});
