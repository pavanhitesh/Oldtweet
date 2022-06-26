/* eslint-disable @typescript-eslint/no-explicit-any */
import { After, Then } from '@cucumber/cucumber';
import { conn } from '../../shared/helpers/force.helper';
import { Fields$OrderApi__Sales_Order_Line__c } from '../../fonteva-schema';

const localSharedData: { [key: string]: string } = {};

After({ tags: '@TEST_PD-29346' }, async () => {
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);

  const deleteCreditNote = await conn.destroy(
    'OrderApi__Credit_Note__c',
    (await browser.sharedStore.get('creditNoteId')) as string,
  );
  expect(deleteCreditNote.success).toEqual(true);
});

Then(`User verifes that the posted date is populated on creditnote related salesOrderLine`, async () => {
  localSharedData.salesOrderId = await ((await browser.sharedStore.get('salesOrderIds')) as string[])[0];
  const solPostedDate = (
    await conn.query<Fields$OrderApi__Sales_Order_Line__c>(
      `SELECT OrderApi__Posted_Date__c FROM OrderApi__Sales_Order_Line__c WHERE OrderApi__Sales_Order__c = '${localSharedData.salesOrderId}' AND OrderApi__Credit_Note__c <> '' AND OrderApi__Sales_Order_Line__c <> ''`,
    )
  ).records[0];

  expect(solPostedDate).not.toBe('');
});
