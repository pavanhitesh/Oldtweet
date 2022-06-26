/* eslint-disable no-console */
import { After, Before, DataTable, Then } from '@cucumber/cucumber';
import * as faker from 'faker';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { Fields$LTE__Site__c, Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { commonPortalPage } from '../../pages/portal/common.page';

Before({ tags: '@TEST_PD-28246' }, async () => {
  await conn.tooling
    .executeAnonymous(`OrderApi__Store__c Store = [Select OrderApi__Enable_Guest_Save_Payment__c FROM OrderApi__Store__c WHERE Name = 'Foundation Store'];
  Store.OrderApi__Enable_Guest_Save_Payment__c = false ;
  Store.OrderApi__Default_Checkout__c = 'Guest Checkout';
  update Store;`);
});

After({ tags: '@TEST_PD-28246' }, async () => {
  const deleteSOResponse = await conn.destroy(
    'OrderApi__Sales_Order__c',
    (await browser.sharedStore.get('salesOrderIds')) as string[],
  );

  deleteSOResponse.forEach((response) => {
    expect(response.success).toEqual(true);
  });
});

Then(
  `User Opens the Portal combo checkout page and verifies the save payment checkbox is not displayed for combos below:`,
  async (comboData: DataTable) => {
    const salesOrdersList = (await browser.sharedStore.get('salesOrderIds')) as string[];
    const invoiceSalesOrderNumbers: string[] = [];
    const receiptSalesOrderNumbers: string[] = [];
    const comboList = comboData.hashes();
    let checkoutURL: string;

    const portalURL = (
      await conn.query<Fields$LTE__Site__c>(`SELECT LTE__Site_URL__c FROM LTE__Site__c where Name = 'LTCommunitySite'`)
    ).records[0].LTE__Site_URL__c as string;

    for (let i = 0; i < salesOrdersList.length; i += 1) {
      const postingEntity = (
        await conn.query<Fields$OrderApi__Sales_Order__c>(
          `SELECT OrderApi__Posting_Entity__c FROM OrderApi__Sales_Order__c WHERE Id = '${salesOrdersList[i]}'`,
        )
      ).records[0].OrderApi__Posting_Entity__c as string;

      if (postingEntity === 'Receipt') receiptSalesOrderNumbers.push(salesOrdersList[i]);
      else invoiceSalesOrderNumbers.push(salesOrdersList[i]);
    }
    await comboList.reduce(async (memo, combo) => {
      await memo;
      if (combo.ComboType === 'Receipt')
        checkoutURL = `${portalURL}/#/store/checkout/${receiptSalesOrderNumbers[0]}` as string;
      else if (combo.ComboType === 'Invoice')
        checkoutURL = `${portalURL}/#/store/checkout/${invoiceSalesOrderNumbers[0]}` as string;
      else if (combo.ComboType === 'Multiple Receipt')
        checkoutURL =
          `${portalURL}/#/store/checkout/${receiptSalesOrderNumbers[0]},${receiptSalesOrderNumbers[1]}` as string;
      else if (combo.ComboType === 'Multiple Invoice')
        checkoutURL =
          `${portalURL}/#/store/checkout/${invoiceSalesOrderNumbers[0]},${invoiceSalesOrderNumbers[1]}` as string;
      else if (combo.ComboType === 'Receipt and Invoice')
        checkoutURL =
          `${portalURL}/#/store/checkout/${invoiceSalesOrderNumbers[0]},${receiptSalesOrderNumbers[0]}` as string;

      await checkoutPage.open(checkoutURL);
      await checkoutPage.waitForAjaxCall();
      if (await checkoutPage.isDisplayed(await commonPortalPage.firstName)) {
        await checkoutPage.fillGuestCheckoutDetails(
          faker.name.firstName(),
          faker.name.lastName(),
          faker.internet.email(),
        );
        await checkoutPage.click(await commonPortalPage.guestRegistrationButton);
      }
      if (combo.ComboType === 'Invoice' || combo.ComboType === 'Multiple Invoice') {
        await checkoutPage.click(await checkoutPage.companyOrderInvoicePaymentContinue);
      }
      await checkoutPage.waitForAjaxCall();
      expect(await checkoutPage.isDisplayed(await checkoutPage.savePaymentMethodOption)).toBe(false);
    }, undefined);
  },
);
