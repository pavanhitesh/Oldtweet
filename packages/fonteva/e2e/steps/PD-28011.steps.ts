/* eslint-disable @typescript-eslint/no-explicit-any */
import { Before, Given, Then, When } from '@cucumber/cucumber';
import * as faker from 'faker';
import { Fields$Contact, Fields$OrderApi__Known_Address__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { knownAddressPage } from '../../pages/salesforce/known-address.page';

const localSharedData: { [key: string]: string | number | boolean } = {};

Before({ tags: '@TEST_PD-28918' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Given(
  'User selects the contact {string} having multiple addresses and navigates to view Known addresses page',
  async (contactName: string) => {
    localSharedData.contactId = (
      await conn.query<Fields$Contact>(`SELECT Id from Contact WHERE Name = '${contactName}'`)
    ).records[0].Id;

    const knownAddressResponse = (
      await conn.query<Fields$OrderApi__Known_Address__c>(
        `SELECT Id from OrderApi__Known_Address__c WHERE OrderApi__Contact__c = '${localSharedData.contactId}' `,
      )
    ).records;
    if (knownAddressResponse.length < 2) {
      const createKnownAddress: any = await conn.create('OrderApi__Known_Address__c', [
        {
          OrderApi__Name__c: 'Shipping Contact1',
          OrderApi__Contact__c: localSharedData.contactId,
          OrderApi__Type__c: 'Shipping',
          OrderApi__Street__c: '10 Downing Street',
          OrderApi__City__c: 'London',
          OrderApi__Province__c: '',
          OrderApi__Country__c: 'GB',
          OrderApi__Postal_Code__c: 'SW1A 2AB',
        },
        {
          OrderApi__Name__c: 'Shipping Contact2',
          OrderApi__Contact__c: localSharedData.contactId,
          OrderApi__Type__c: 'Shipping',
          OrderApi__Street__c: 'Castle Rising',
          OrderApi__City__c: 'Newark',
          OrderApi__Province__c: '',
          OrderApi__Country__c: 'GB',
          OrderApi__Postal_Code__c: 'NG24 1XW',
        },
      ]);
      expect(createKnownAddress[0].success).toEqual(true);
      expect(createKnownAddress[1].success).toEqual(true);
    }
    await knownAddressPage.open(
      `/lightning/r/Contact/${localSharedData.contactId}/related/OrderApi__Known_Addresses__r/view`,
    );
    await knownAddressPage.waitForPresence(await knownAddressPage.newButton);
    expect(await knownAddressPage.isDisplayed(await knownAddressPage.newButton)).toEqual(true);
  },
);

Given('user navigates to manage known addresses', async () => {
  await knownAddressPage.click(await knownAddressPage.newButton);
  await knownAddressPage.waitForPresence(await knownAddressPage.addressListFrame);
  await knownAddressPage.switchToFrame(await knownAddressPage.addressListFrame);
  await knownAddressPage.waitForPresence(await knownAddressPage.newAddressButton);
  expect(await knownAddressPage.isDisplayed(await knownAddressPage.newAddressButton)).toEqual(true);
});

When('user selects one of the address to edit', async () => {
  const knownAddressId = (
    await conn.query<Fields$OrderApi__Known_Address__c>(
      `SELECT Id from OrderApi__Known_Address__c WHERE OrderApi__Contact__c = '${localSharedData.contactId}' `,
    )
  ).records[0].Id;
  knownAddressPage.editKnowAddressId = knownAddressId;
  await knownAddressPage.click(await knownAddressPage.editAddressButton);
  await knownAddressPage.waitForPresence(await knownAddressPage.enterManualAddressCheckBox);
  expect(await knownAddressPage.isDisplayed(await knownAddressPage.enterManualAddressCheckBox)).toEqual(true);
});

When('user click on Enter Address Manually Checkbox', async () => {
  await knownAddressPage.click(await knownAddressPage.enterManualAddressCheckBox);
  await knownAddressPage.waitForPresence(await knownAddressPage.stateDropDown);
  expect(await knownAddressPage.isDisplayed(await knownAddressPage.stateDropDown)).toEqual(true);
});

Then('user verifies the country is populated', async () => {
  const country = await knownAddressPage.getSelectedOption(await knownAddressPage.countryDropDown);
  expect(country).not.toBeNull();
});

Then(
  'user verifies the validation message is displayed as {string} when country is blank and street is modified',
  async (errorMessage: string) => {
    await knownAddressPage.selectByVisibleText(await knownAddressPage.countryDropDown, '--Select--');
    await knownAddressPage.type(await knownAddressPage.streetTextBox, faker.random.alphaNumeric(5));
    await knownAddressPage.click(await knownAddressPage.saveButton);
    await knownAddressPage.waitForPresence(await knownAddressPage.countryErrorMessage);
    expect(await knownAddressPage.getText(await knownAddressPage.countryErrorMessage)).toEqual(errorMessage);
  },
);
