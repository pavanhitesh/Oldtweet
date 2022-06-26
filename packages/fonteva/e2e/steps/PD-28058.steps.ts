import { After, Given, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$OrderApi__Renewal__c } from '../../fonteva-schema';
import { additionalItemsPage } from '../../pages/portal/additional-items.page';
import { commonPortalPage } from '../../pages/portal/common.page';

const localSharedData: { [key: string]: string } = {};

After({ tags: '@TEST_PD-29092' }, async () => {
  const deleteSubscription = await conn.sobject('OrderApi__Subscription__c').destroy(localSharedData.subscriptionId);
  expect(deleteSubscription.success).toEqual(true);
  const deleteSO = await conn
    .sobject('OrderApi__Sales_Order__c')
    .destroy((await browser.sharedStore.get('portalSO')) as string);
  expect(deleteSO.success).toEqual(true);
});

Given('User should be able to select additional item {string} and navigate to add to order page', async (itemName) => {
  additionalItemsPage.singleAdditionalItem = itemName;
  await additionalItemsPage.click(await additionalItemsPage.selectAdditionalItem);
  await additionalItemsPage.click(await additionalItemsPage.continue);
  await additionalItemsPage.waitForAbsence(await additionalItemsPage.continue);
  await commonPortalPage.waitForPresence(await commonPortalPage.buttonAddtoCartFromItemDetails);
  await commonPortalPage.click(await commonPortalPage.buttonAddtoCartFromItemDetails);
  await commonPortalPage.waitForPresence(await commonPortalPage.buttonAddtoCart);
  expect(await commonPortalPage.isDisplayed(await commonPortalPage.buttonAddtoCart)).toBe(true);
});

Then('User verfies subscription has one active assignments and only one subscriber', async () => {
  localSharedData.subscriptionId = (
    await conn.query<Fields$OrderApi__Renewal__c>(
      `SELECT OrderApi__Subscription__c FROM OrderApi__Renewal__c WHERE OrderApi__Sales_Order__c = '${await browser.sharedStore.get(
        'portalSO',
      )}'`,
    )
  ).records[0].OrderApi__Subscription__c as string;

  const assignmentResponse = await conn.query(
    `Select OrderApi__Subscription__r.OrderApi__Active_Assignments__c from OrderApi__Assignment__c where OrderApi__Subscription__c = '${localSharedData.subscriptionId}'`,
  );
  expect(assignmentResponse.totalSize).toEqual(1);
  expect(assignmentResponse.records[0].OrderApi__Subscription__r.OrderApi__Active_Assignments__c).toEqual(1);
});
