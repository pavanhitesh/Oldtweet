/* eslint-disable no-console */
import { Given, When, DataTable, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { additionalItemsPage } from '../../pages/portal/additional-items.page';
import { eventRegistrationPage } from '../../pages/portal/event-registration.page';
import {
  Fields$EventApi__Event__c,
  Fields$OrderApi__Item__c,
  Fields$OrderApi__Renewal__c,
  Fields$PagesApi__Field_Group__c,
  Fields$User,
} from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { profilePage } from '../../pages/portal/profile.page';
import { portalLoginPage } from '../../pages/portal/login.page';
import { portalSelfRegisterPage } from '../../pages/portal/self-register.page';
import { commonPortalPage } from '../../pages/portal/common.page';
import { assignMemberPage } from '../../pages/portal/assign-members.page';
import { receiptPage } from '../../pages/portal/receipt.page';
import { creditCardComponent } from '../../pages/portal/components/credit-card.component';
import { addressComponent } from '../../pages/portal/components/address.component';
import * as data from '../data/common-data.json';
import { shoppingCartPage } from '../../pages/portal/shopping-cart.page';
import { subscriptionPage } from '../../pages/portal/subscription.page';
import { subscriptionToRenewPage } from '../../pages/portal/subscriptions-to-renew.page';
import { manageSubscriptionPage } from '../../pages/portal/manage-subscription.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';
import { attendeeModalPage } from '../../pages/portal/attendee-modal.page';
import { agendaPage } from '../../pages/portal/agenda.page';
import { ticketPage } from '../../pages/portal/ticket.page';
import { recommendedItemsPage } from '../../pages/portal/recommend-items.page';
import { communitySitePage } from '../../pages/salesforce/community-site.page';
import { formPage } from '../../pages/portal/form.page';
import { storePage } from '../../pages/portal/store.page';

Given('User will select the {string} page in LT Portal', async (pageName: string) => {
  profilePage.selectProfilePage = pageName;
  await profilePage.click(await profilePage.navigateToProfilePage);
  await profilePage.waitForPresence(await profilePage.pageheader);
  expect(await profilePage.getText(await profilePage.pageheader)).toEqual(pageName);
});

Given(
  'User navigate to community Portal page with {string} user and password {string} as {string} user',
  async (username: string, password: string, user: string) => {
    if (user === 'authenticated') {
      await portalLoginPage.open();
      await portalLoginPage.click(await portalLoginPage.loginLink);
      await portalLoginPage.portalLogin(username, password);
      await profilePage.waitForClickable(await commonPortalPage.linkStore);
      expect(await portalLoginPage.isDisplayed(await commonPortalPage.linkStore)).toEqual(true);
      const contactInfo = (
        await conn.query<Fields$User>(`SELECT Name, ContactId FROM User WHERE Username='${username}'`)
      ).records[0];
      await browser.sharedStore.set('contactId', contactInfo.ContactId as string);
      await browser.sharedStore.set('contactName', contactInfo.Name as string);
    } else {
      await portalLoginPage.open();
      await portalLoginPage.waitForClickable(await commonPortalPage.linkStore);
      expect(await portalLoginPage.isDisplayed(await commonPortalPage.linkStore)).toEqual(true);
    }
  },
);

Given('User navigate to community Portal Self register page', async () => {
  await portalLoginPage.open();
  await portalLoginPage.click(await portalLoginPage.loginLink);
  await portalLoginPage.click(await portalLoginPage.notMember);
  await portalLoginPage.sleep(MilliSeconds.S);
  expect(await portalSelfRegisterPage.isDisplayed(await portalSelfRegisterPage.logo)).toEqual(true);
});

Given(
  'User should be able to select {string} item with quantity {string} on store',
  async (item: string, quantity: string) => {
    await profilePage.click(await commonPortalPage.linkStore);
    await profilePage.waitForPresence(await commonPortalPage.buttonSearch);
    const { records } = await conn.query<Fields$OrderApi__Item__c>(
      `Select OrderApi__Is_Subscription__c from OrderApi__item__c where Name= '${item}'`,
    );
    if (records.length === 0) {
      throw new Error('Item not found');
    } else {
      await commonPortalPage.selectItem(item);
      if (records[0].OrderApi__Is_Subscription__c === false) {
        await commonPortalPage.selectByVisibleText(
          await $('//div[contains(@class, "pfm-detail_quantity")]//select'),
          quantity,
        );
      }
      expect(await commonPortalPage.isDisplayed(await commonPortalPage.buttonAddtoCart)).toEqual(true);
      await commonPortalPage.clickOnAddToCartButton();
      await commonPortalPage.waitForAbsence(await commonPortalPage.buttonSpinner);
      await commonPortalPage.sleep(MilliSeconds.XXS);
      browser.sharedStore.set('itemName', item);
    }
  },
);

When('User select assign members for subscription', async (members: DataTable) => {
  const orderData = members.hashes();
  await orderData.reduce(async (memo, member) => {
    await memo;
    await assignMemberPage.slowTypeFlex(await assignMemberPage.searchMember, member.name);
    if ((await assignMemberPage.assignMemberIsSelected(member.name)) === false) {
      await assignMemberPage.selectAssignMember(member.name);
    }
    await assignMemberPage.selectAssignmentRole(member.name, member.role);
    expect(await assignMemberPage.assignMemberIsSelected(member.name)).toBe(true);
  }, undefined);
  await assignMemberPage.click(await assignMemberPage.AddToCart);
  await assignMemberPage.waitForAbsence(await assignMemberPage.AddToCart);
  expect(await assignMemberPage.AddToCart.isDisplayed()).toBe(false);
});

Then('User should be able to select additional items', async (items: DataTable) => {
  const orderData = items.hashes();
  await orderData.reduce(async (memo, item) => {
    if (item.name !== 'NA') {
      additionalItemsPage.modalAdditionalItem = item.name;
      additionalItemsPage.singleAdditionalItem = item.name;
      await additionalItemsPage.waitForClickable(await additionalItemsPage.continue);
      await memo;
      if (await additionalItemsPage.isDisplayed(await additionalItemsPage.addItem)) {
        await additionalItemsPage.click(await additionalItemsPage.addItem);
        await additionalItemsPage.waitForPresence(await additionalItemsPage.modalHeader);
        await additionalItemsPage.click(await additionalItemsPage.selectAdditionalItemOnModal);
      } else {
        await additionalItemsPage.click(await additionalItemsPage.selectAdditionalItem);
      }
    }
  }, undefined);
  await additionalItemsPage.click(await additionalItemsPage.continue);
  await additionalItemsPage.waitForAbsence(await additionalItemsPage.continue);
  expect(await additionalItemsPage.isDisplayed(await additionalItemsPage.continue)).toBe(false);
});

Then('User should see the {string} created confirmation message', async (confirmationType: string) => {
  if (confirmationType === 'receipt') {
    await receiptPage.waitForPresence(await receiptPage.paymentConfirmationMessage);
    expect(await receiptPage.paymentConfirmationMessage).toBeDisplayed();
  } else {
    await receiptPage.waitForPresence(await receiptPage.invoiceConfirmationMessage);
    expect(await receiptPage.invoiceConfirmationMessage.isDisplayed()).toBe(true);
  }
});

When('User navigates to checkout page as guest', async () => {
  await commonPortalPage.click(await commonPortalPage.guestRegistrationButton);
  await commonPortalPage.waitForAbsence(await commonPortalPage.buttonSpinner);
  await commonPortalPage.waitForPresence(await commonPortalPage.checkoutPageLabel);
  expect(await commonPortalPage.textBoxSourceCode.isDisplayed()).toBe(true);
});

When('User should click on the checkout button', async () => {
  await commonPortalPage.clickCheckoutbutton();
  const orgId = await browser.sharedStore.get('organizationId');
  const cookieSalesOrderId = JSON.parse(
    (await browser.getCookies([`apex__${orgId}-fonteva-community-shopping-cart`]))[0].value,
  ).salesOrderId;
  browser.sharedStore.set('portalSO', cookieSalesOrderId);
  expect(await commonPortalPage.textBoxSourceCode.isDisplayed()).toBe(true);
});

When(`User successfully pays for the order using credit card`, async () => {
  if (await addressComponent.isDisplayed(await addressComponent.buttonContinue)) {
    await addressComponent.click(await addressComponent.buttonContinue);
  }
  await creditCardComponent.waitForPresence(await creditCardComponent.linkCreditCard);
  await creditCardComponent.addNewCreditCardDetails(
    data.creditCardNumber,
    data.creditCardCVV,
    data.creditCardExpMonth,
    data.creditCardExpYear,
  );
  await creditCardComponent.click(await creditCardComponent.buttonProcessPayment);
  await creditCardComponent.waitForAbsence(await creditCardComponent.buttonProcessPayment);
  expect(await creditCardComponent.buttonProcessPayment.isDisplayed()).toBe(false);
});

Then('User navigate to checkout from shopping cart page', async () => {
  await shoppingCartPage.waitForPresence(await shoppingCartPage.header);
  const cookie = JSON.parse(
    (
      await browser.getCookies([
        `apex__${await browser.sharedStore.get('organizationId')}-fonteva-community-shopping-cart`,
      ])
    )[0].value,
  ).salesOrderId;
  browser.sharedStore.set('portalSO', cookie);
  await shoppingCartPage.click(await shoppingCartPage.cartCheckout);
  await shoppingCartPage.waitForPresence(await commonPortalPage.textBoxSourceCode);
  expect(await commonPortalPage.checkoutPageLabel.isDisplayed()).toBe(true);
});

Given(
  'User should be able to click on {string} subscription purchased using {string}',
  async (actionType: string, checkoutType: string) => {
    let subscriptionId = '';
    if (checkoutType === 'backend') {
      subscriptionId = (
        await conn.query<Fields$OrderApi__Renewal__c>(
          `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c IN (SELECT OrderApi__Sales_Order__c FROM OrderApi__Receipt__c WHERE Name = '${await browser.sharedStore.get(
            'receiptNameROE',
          )}')`,
        )
      ).records[0].OrderApi__Subscription__c;
    } else if (checkoutType === 'portal') {
      subscriptionId = (
        await conn.query<Fields$OrderApi__Renewal__c>(
          `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
            'portalSO',
          )}'`,
        )
      ).records[0].OrderApi__Subscription__c;
    } else if (checkoutType === 'restService') {
      subscriptionId = (
        await conn.query<Fields$OrderApi__Renewal__c>(
          `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
            'SalesOrderId',
          )}'`,
        )
      ).records[0].OrderApi__Subscription__c;
    }
    browser.sharedStore.set('subscriptionId', subscriptionId);
    if (actionType === 'renew') {
      subscriptionPage.subscriptionToRenew = subscriptionId;
      await subscriptionPage.click(await subscriptionPage.renewSubscription);
      await subscriptionToRenewPage.waitForPresence(await subscriptionToRenewPage.renewHeader);
      expect(await subscriptionToRenewPage.isDisplayed(await subscriptionToRenewPage.renewHeader)).toEqual(true);
    } else if (actionType === 'manage') {
      subscriptionPage.subscriptionToManage = subscriptionId;
      await subscriptionPage.click(await subscriptionPage.manageSubscription);
      await manageSubscriptionPage.waitForPresence(await manageSubscriptionPage.updatePaymentMethod);
      expect(await manageSubscriptionPage.isDisplayed(await manageSubscriptionPage.updatePaymentMethod)).toEqual(true);
    }
  },
);

Then('User should be able to select {string} renew item', async (renewItem: string) => {
  subscriptionToRenewPage.subscriptionToRenew = renewItem;
  await subscriptionToRenewPage.click(await subscriptionToRenewPage.renewSubscription);
  await subscriptionToRenewPage.waitForClickable(await subscriptionToRenewPage.change);
  expect(await subscriptionToRenewPage.change.isDisplayed()).toEqual(true);
});

Then(
  'User selects event {string} and event type {string} on LT portal',
  async (eventName: string, eventType: string) => {
    const eventId = (
      await conn.query<Fields$EventApi__Event__c>(`SELECT Id FROM EventApi__Event__c WHERE
  EventApi__Display_Name__c='${eventName}'`)
    ).records[0].Id;
    await browser.sharedStore.set('eventId', eventId);
    await eventRegistrationPage.open(`${await browser.sharedStore.get('portalUrl')}${data.eventPageLT}${eventId}`);
    if (eventType === 'MultiTicket') {
      await eventRegistrationPage.waitForClickable(await eventRegistrationPage.registerEvent);
      expect(await eventRegistrationPage.registerEvent.isDisplayed()).toEqual(true);
    } else {
      await eventRegistrationPage.waitForClickable(await eventRegistrationPage.registerNow);
      expect(await eventRegistrationPage.registerNow.isDisplayed()).toEqual(true);
    }
  },
);

When(`User successfully pays for the event using credit card`, async () => {
  await creditCardComponent.waitForPresence(await creditCardComponent.linkCreditCard);
  await creditCardComponent.addNewCreditCardDetails(
    data.creditCardNumber,
    data.creditCardCVV,
    data.creditCardExpMonth,
    data.creditCardExpYear,
  );
  const cookieSalesOrderId = JSON.parse(
    (
      await browser.getCookies([
        `apex__${await browser.sharedStore.get('organizationId')}-fonteva-lightning-shopping-cart`,
      ])
    )[0].value,
  ).salesOrderId;
  browser.sharedStore.set('portalSO', cookieSalesOrderId);
  await creditCardComponent.click(await creditCardComponent.buttonProcessPayment);
  await creditCardComponent.waitForAbsence(await creditCardComponent.buttonProcessPayment);
  await receiptPage.waitForPresence(await receiptPage.viewReceipt);
  expect(await receiptPage.viewReceipt.isDisplayed()).toEqual(true);
});

When('User manages the assign members for the existing subscription', async (members: DataTable) => {
  await subscriptionPage.click(await subscriptionPage.members);
  await assignMemberPage.waitForPresence(await assignMemberPage.searchMember);
  expect(await assignMemberPage.isDisplayed(await assignMemberPage.searchMember)).toBe(true);
  const orderData = members.hashes();
  await orderData.reduce(async (memo, member) => {
    await memo;
    if ((member.newContact as string).toLowerCase() === 'yes') {
      await assignMemberPage.click(await assignMemberPage.addMember);
      await assignMemberPage.waitForPresence(await assignMemberPage.addMemberHeader);
      await assignMemberPage.type(await assignMemberPage.addMemberLastName, member.name);
      await assignMemberPage.click(await assignMemberPage.addMemberDone);
      await assignMemberPage.waitForAbsence(await assignMemberPage.addMemberHeader);
      expect(await assignMemberPage.isDisplayed(await assignMemberPage.addMemberHeader)).toBe(false);
    }
    await assignMemberPage.slowTypeFlex(await assignMemberPage.searchMember, member.name);
    if ((await assignMemberPage.assignMemberIsSelected(member.name)) === false) {
      await assignMemberPage.selectAssignMember(member.name);
    }
    await assignMemberPage.selectAssignmentRole(member.name, member.role);
    expect(await assignMemberPage.assignMemberIsSelected(member.name)).toBe(true);
  }, undefined);
});

Then(
  'User register for {string} ticket with {int} quantity and navigate to {string} page as {string}',
  async (ticket: string, quantity: number, page: string, accessType: string) => {
    await eventRegistrationPage.click(await eventRegistrationPage.registerEvent);
    await ticketPage.sleep(MilliSeconds.XXS);
    await browser.sharedStore.set('ticketName', ticket);

    if (accessType === 'Guest') {
      await portalSelfRegisterPage.waitForPresence(await portalSelfRegisterPage.firstName);
      await portalSelfRegisterPage.type(await portalSelfRegisterPage.firstName, faker.name.firstName());
      await portalSelfRegisterPage.type(await portalSelfRegisterPage.lastName, faker.name.lastName());
      await portalSelfRegisterPage.type(await portalSelfRegisterPage.email, faker.internet.email());
      await portalSelfRegisterPage.waitForClickable(await portalSelfRegisterPage.guestContinueButton);
      await portalSelfRegisterPage.click(await portalSelfRegisterPage.guestContinueButton);
    }

    await ticketPage.selectTicket(ticket, quantity);
    await ticketPage.click(await ticketPage.continue);

    if (page === 'attendee modal') {
      await recommendedItemsPage.waitForPresence(await attendeeModalPage.continue);
      expect(await agendaPage.isDisplayed(await attendeeModalPage.continue)).toEqual(true);
    } else if (page === 'session') {
      await attendeeModalPage.click(await attendeeModalPage.continue);
      await recommendedItemsPage.waitForPresence(await agendaPage.agendaLink);
      expect(await agendaPage.isDisplayed(await agendaPage.agendaLink)).toEqual(true);
    }
  },
);

Then(
  'User selects {string} sessions on agenda page and navigate to {string} page',
  async (session: string, page: string) => {
    if (session === 'NA') {
      await agendaPage.click(await agendaPage.continue);
    }

    if (page === 'packageItems') {
      await recommendedItemsPage.waitForPresence(await recommendedItemsPage.recommendeditemLink);
      expect(await recommendedItemsPage.recommendeditemLink.isDisplayed()).toEqual(true);
    } else if (page === 'checkout') {
      await addressComponent.waitForPresence(await addressComponent.buttonCreateAddress);
      expect(await addressComponent.isDisplayed(await addressComponent.buttonCreateAddress)).toEqual(true);
    }
  },
);

Then('User opens {string} form page', async (formName: string) => {
  await browser.sharedStore.set('formName', formName);
  const url: string = (await conn.query(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`))
    .records[0].LTE__Site_URL__c;
  const formId = (await conn.query(`SELECT Id FROM PagesApi__Form__c WHERE Name = '${formName}'`)).records[0].Id;
  await portalLoginPage.waitForPresence(await commonPortalPage.linkStore);
  expect(await portalLoginPage.isDisplayed(await commonPortalPage.linkStore)).toEqual(true);
  await communitySitePage.open(`${url}/formpage?id=${formId}`);

  await formPage.waitForPresence(await formPage.name);
  expect(await formPage.getText(await formPage.name)).toEqual(formName);
});

Given('User create a form {string}', async (formName: string, formfieldData: DataTable) => {
  await browser.sharedStore.set('formName', formName);
  const groupIds: string[] = [];
  const isRequiredValues: string[] = [];
  const formGroupNames: string[] = [];
  const formFieldTypes: string[] = [];
  const formFieldNames: string[] = [];
  const formFieldIds: string[] = [];
  const fieldCreationData = formfieldData.hashes();
  await fieldCreationData.reduce(async (memo, formData) => {
    await memo;
    isRequiredValues.push(await formData.isRequired);
    formGroupNames.push(await formData.formGroupName);
    formFieldTypes.push(await formData.formFieldType);
    formFieldNames.push(await formData.formFieldName);
    const createForm: any = await conn.create('PagesApi__Form__c', [
      {
        Name: await browser.sharedStore.get('formName'),
      },
    ]);
    expect(createForm[0].success).toEqual(true);
    await browser.sharedStore.set('formId', createForm[0].id as string);
    const fieldGroupRecords = await (
      await conn.query<Fields$PagesApi__Field_Group__c>(
        `SELECT Id FROM PagesApi__Field_Group__c WHERE ( PagesApi__Form__c = '${await browser.sharedStore.get(
          'formId',
        )}' And PagesApi__Field_Group__c.Name = '${await browser.sharedStore.get('formGroupName')}')`,
      )
    ).records;
    let createGroup: any;
    if (fieldGroupRecords.length === 0) {
      createGroup = await conn.create('PagesApi__Field_Group__c', [
        {
          Name: formData.formGroupName,
          PagesApi__Form__c: await browser.sharedStore.get('formId'),
        },
      ]);
      expect(createGroup[0].success).toEqual(true);
      groupIds.push(await createGroup[0].id);
    }
    if (formData.formFieldType === 'Multipicklist' || formData.formFieldType === 'Picklist') {
      const createField: any = await conn.create('PagesApi__Field__c', [
        {
          Name: formData.formFieldName,
          PagesApi__Field_Group__c: createGroup[0].id,
          PagesApi__Type__c: formData.formFieldType,
          PagesApi__Options__c: formData.options,
          PagesApi__Is_Required__c: formData.isRequired as boolean,
        },
      ]);
      expect(createField[0].success).toEqual(true);
      formFieldIds.push(await createField[0].id);
    } else {
      const createField: any = await conn.create('PagesApi__Field__c', [
        {
          Name: formData.formFieldName,
          PagesApi__Field_Group__c: createGroup[0].id,
          PagesApi__Type__c: formData.formFieldType,
          PagesApi__Is_Required__c: formData.isRequired as boolean,
        },
      ]);
      expect(createField[0].success).toEqual(true);
      formFieldIds.push(await createField[0].id);
    }
  }, undefined);
  await browser.sharedStore.set('groupIds', groupIds);
  await browser.sharedStore.set('fieldIds', formFieldIds);
  await browser.sharedStore.set('isRequired', isRequiredValues);
  await browser.sharedStore.set('formGroupNames', formGroupNames);
  await browser.sharedStore.set('formFieldTypes', formFieldTypes);
  await browser.sharedStore.set('formFieldNames', formFieldNames);
});

When(
  'User should be able to select {string} item with subscription plan {string} on store',
  async (item: string, plan: string) => {
    await commonPortalPage.click(await commonPortalPage.linkStore);
    await commonPortalPage.waitForPresence(await commonPortalPage.buttonSearch);
    await storePage.selectItemwithSubscriptionPlan(item, plan);
    await storePage.click(await storePage.addToOrderButton);
    await storePage.click(await storePage.addToCartButton);
    await commonPortalPage.waitForAbsence(await commonPortalPage.buttonSpinner);
    browser.sharedStore.set('itemName', item);
    await storePage.waitForPresence(await storePage.addToOrderButton);
    expect(await storePage.isDisplayed(await storePage.addToOrderButton)).toEqual(true);
  },
);
