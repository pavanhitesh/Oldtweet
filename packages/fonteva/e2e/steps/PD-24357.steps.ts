import { Before, Then } from '@cucumber/cucumber';
import { rapidOrderEntryPage } from '../../pages/salesforce/rapid-order-entry.page';
import { loginPage } from '../../pages/salesforce/login.page';
import { contactPage } from '../../pages/salesforce/contact.page';

Before({ tags: '@TEST_PD-27072' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

Then(
  'User should be able to select {string} and verify the {string} discount code at roe',
  async (item: string, discountCode: string) => {
    await contactPage.click(await contactPage.rapidOrderEntry);
    await rapidOrderEntryPage.slowTypeFlex(await rapidOrderEntryPage.itemQuickAdd, item);
    await rapidOrderEntryPage.Keyboard('Return');
    await rapidOrderEntryPage.click(await rapidOrderEntryPage.addToOrder);
    await rapidOrderEntryPage.slowTypeFlex(await rapidOrderEntryPage.discountCode, discountCode);
    await rapidOrderEntryPage.Keyboard('Return');
    const result = await rapidOrderEntryPage.getAttributeValue(await rapidOrderEntryPage.applyDiscountCode, 'disabled');
    expect(result).toEqual('true');
  },
);
