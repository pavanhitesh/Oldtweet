import { After, Before, When } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { myCompanyInfoPage } from '../../pages/portal/company-info.page';
import { Fields$Account } from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29533' }, async () => {
  const enableCompanyInfoMenu = await conn.tooling
    .executeAnonymous(`LTE__Menu_Item__c menuItemInfo = [SELECT LTE__Enable_Access_Permissions__c FROM LTE__Menu_Item__c WHERE Name = 'My Company Info' AND LTE__Site__r.Name = 'LTCommunitySite'];
  menuItemInfo.LTE__Enable_Access_Permissions__c = false;
  update menuItemInfo;`);
  expect(enableCompanyInfoMenu.success).toEqual(true);
});

After({ tags: '@TEST_PD-29533' }, async () => {
  const disableCompanyInfoMenu = await conn.tooling
    .executeAnonymous(`LTE__Menu_Item__c menuItemInfo = [SELECT LTE__Enable_Access_Permissions__c FROM LTE__Menu_Item__c WHERE Name = 'My Company Info' AND LTE__Site__r.Name = 'LTCommunitySite'];
  menuItemInfo.LTE__Enable_Access_Permissions__c = true;
  update menuItemInfo;`);
  expect(disableCompanyInfoMenu.success).toEqual(true);
});

When(`User tries to change data for the fieldset {string}`, async (fieldsetName: string) => {
  myCompanyInfoPage.fieldSetToEdit = fieldsetName;
  localSharedData.AccountfieldSetName = fieldsetName;
  await myCompanyInfoPage.click(await myCompanyInfoPage.change);
  await myCompanyInfoPage.waitForAbsence(await myCompanyInfoPage.change);
  expect(await myCompanyInfoPage.isDisplayed(await myCompanyInfoPage.change)).toBe(false);
});

When(
  `User updates annual revenue of the account {string} to {int} and verifies the value in portal and backend`,
  async (accountName: string, revenue: number) => {
    const accountRevenue = (
      await conn.query<Fields$Account>(`SELECT AnnualRevenue FROM Account WHERE Name = '${accountName}'`)
    ).records[0].AnnualRevenue;

    if (accountRevenue === revenue) {
      const annualRevenueUpdateStatus = await conn.tooling
        .executeAnonymous(`Account accountInfo = [Select AnnualRevenue from Account Where Name = '${accountName}'];
  accountInfo.AnnualRevenue = 1000;
  update accountInfo;`);
      expect(annualRevenueUpdateStatus.success).toEqual(true);
    }

    await myCompanyInfoPage.type(await myCompanyInfoPage.annualRevenueInput, revenue);
    myCompanyInfoPage.fieldSetToSave = localSharedData.AccountfieldSetName;
    await myCompanyInfoPage.click(await myCompanyInfoPage.save);
    await myCompanyInfoPage.waitForAbsence(await myCompanyInfoPage.save);
    expect(await myCompanyInfoPage.isDisplayed(await myCompanyInfoPage.save)).toBe(false);
    const updatedAccountRevenuePortal = +(await myCompanyInfoPage.getText(await myCompanyInfoPage.annualRevenueValue))
      .replace(new RegExp(',', 'g'), '')
      .replace('$', '');

    expect(updatedAccountRevenuePortal).toEqual(revenue);

    const updatedAccountRevenueBackend = (
      await conn.query<Fields$Account>(`SELECT AnnualRevenue FROM Account WHERE Name = '${accountName}'`)
    ).records[0].AnnualRevenue;

    expect(updatedAccountRevenueBackend).toEqual(revenue);
    expect(updatedAccountRevenueBackend).toEqual(updatedAccountRevenuePortal);
  },
);
