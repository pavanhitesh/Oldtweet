import { After, Before, Then } from '@cucumber/cucumber';
import { Fields$Contact, Fields$PagesApi__Form_Response__c } from 'packages/fonteva/fonteva-schema';
import faker from 'faker';
import { loginPage } from '../../pages/salesforce/login.page';
import { formPage } from '../../pages/portal/form.page';
import { conn } from '../../shared/helpers/force.helper';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29572' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User validate the auto populated fields on form with user details for contact {string}',
  async (userName: string) => {
    localSharedData.userName = userName;
    formPage.inputForAccount = `User Email`;
    expect(await formPage.isDisplayed(await formPage.inputforAccountDetails)).toEqual(true);
    const userRecords = (
      await conn.query<Fields$Contact>(
        `SELECT Email, MobilePhone, Title FROM user WHERE Name='${localSharedData.userName}'`,
      )
    ).records[0];

    expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(userRecords.Email);
    formPage.inputForAccount = `Mobile`;
    expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(userRecords.MobilePhone);
    formPage.inputForAccount = `Title`;
    expect(await formPage.getTextUsingJS(await formPage.inputforAccountDetails)).toEqual(userRecords.Title);
  },
);

Then('User submits the form and validates the user record details are updated', async () => {
  localSharedData.mobileNum = faker.phone.phoneNumber();
  localSharedData.titleName = faker.name.title();
  localSharedData.userEmail = faker.internet.email();
  formPage.inputForAccount = `User Email`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.userEmail);
  formPage.inputForAccount = `Mobile`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.mobileNum);
  formPage.inputForAccount = `Title`;
  await formPage.type(await formPage.inputforAccountDetails, localSharedData.titleName);
  await formPage.click(await formPage.submit);
  await formPage.waitForPresence(await formPage.submit);
  const userData = (
    await conn.query<Fields$Contact>(
      `SELECT Email, MobilePhone, Title FROM user WHERE Name='${localSharedData.userName}'`,
    )
  ).records[0];
  expect(userData.MobilePhone).toEqual(localSharedData.mobileNum);
  expect(userData.Title).toEqual(localSharedData.titleName);
  expect(userData.Email).toEqual(localSharedData.userEmail);
});

After({ tags: 'TEST_PD-29572' }, async () => {
  const formResponseId = await (
    await conn.query<Fields$PagesApi__Form_Response__c>(
      `SELECT Id from PagesApi__Form_Response__c where PagesApi__Form__r.Name = '${await browser.sharedStore.get(
        'formName',
      )}'`,
    )
  ).records[0].Id;
  const deleteFormResponse = await conn.sobject('PagesApi__Form_Response__c').destroy(formResponseId);
  expect(deleteFormResponse.success).toEqual(true);
});
