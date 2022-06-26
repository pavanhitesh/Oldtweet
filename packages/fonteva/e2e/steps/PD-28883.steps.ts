import { After } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';

After({ tags: '@TEST_PD-28910' }, async () => {
  const salesOrderDeleted = await conn.destroy(
    'OrderApi__Sales_Order__c',
    `${await browser.sharedStore.get('portalSO')}`,
  );
  expect(salesOrderDeleted.success).toEqual(true);
});
