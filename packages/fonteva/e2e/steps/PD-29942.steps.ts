import { DataTable, Before, Then } from '@cucumber/cucumber';
import { formPage } from '../../pages/portal/form.page';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { MilliSeconds } from '../../../../globals/enums/milliseconds.enum';

Before({ tags: '@TEST_PD-29943' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  `User verifies the display of fields based on the Skip logic for {string} with the field {string}`,
  async (carbrand: string, carModel: string, skipLogicFields: DataTable) => {
    await rapidOrderEntryPage.expandItemtoViewDetails((await browser.sharedStore.get('itemName')) as string);
    await rapidOrderEntryPage.sleep(MilliSeconds.XXS);
    await rapidOrderEntryPage.click(await rapidOrderEntryPage.attachedFormElement);
    const dataTable = skipLogicFields.hashes();
    await dataTable.reduce(async (memo, orderData) => {
      await memo;
      formPage.formSelect = carbrand;
      await formPage.scrollToElement(await formPage.formSelectDetails);
      await rapidOrderEntryPage.selectByVisibleText(await formPage.formSelectDetails, orderData.brandName);
      await rapidOrderEntryPage.sleep(MilliSeconds.XXXS);
      expect(await formPage.isDisplayed(await formPage.formSelectDetails)).toEqual(true);
      rapidOrderEntryPage.skipLogicInstructionalText = 'Origin Country';
      expect(await rapidOrderEntryPage.getText(await rapidOrderEntryPage.skipLogicInstructionalTextDetails)).toEqual(
        orderData.originCountry,
      );
      formPage.inputForAccount = carModel;
      expect(await formPage.isDisplayed(await formPage.inputforAccountDetails)).toEqual(true);
    });
  },
);
