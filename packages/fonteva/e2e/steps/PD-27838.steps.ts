import { Before } from '@cucumber/cucumber';
import { loginPage } from '../../pages/salesforce/login.page';
import { contactPage } from '../../pages/salesforce/contact.page';
import * as data from '../data/PD-27838.json';

Before({ tags: '@REQ_PD-27838' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
  await contactPage.deleteKnownAddress(data.contactName);
});
