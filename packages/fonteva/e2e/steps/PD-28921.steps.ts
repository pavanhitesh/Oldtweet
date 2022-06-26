import { Then } from '@cucumber/cucumber';
import { recommendedItemsPage } from '../../pages/portal/recommend-items.page';

Then(
  'User add {string} package item and verifies quantity restriction is not displayed',
  async (recommendedItemName: string) => {
    await recommendedItemsPage.selectRecommendedItem(recommendedItemName);
    await recommendedItemsPage.waitForClickable(await recommendedItemsPage.addToOrder);
    expect(await recommendedItemsPage.quantity.isDisplayed()).toEqual(false);
  },
);
