import { Then, After } from '@cucumber/cucumber';
import { eventCheckoutPage } from '../../pages/portal/event-checkout.page';
import { addressComponent } from '../../pages/portal/components/address.component';
import { Fields$OrderApi__Custom_Payment_Type__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';

After({ tags: '@TEST_PD-29246' }, async () => {
  const paymentTypeIds: string[] = [];
  const paymentTypeNamesList = (await browser.sharedStore.get('paymentTypeNames')) as string[];
  paymentTypeNamesList.forEach(async (paymentType) => {
    const paymentTypeId = (
      await conn.query<Fields$OrderApi__Custom_Payment_Type__c>(
        `SELECT Id FROM OrderApi__Custom_Payment_Type__c WHERE Name = '${paymentType}'`,
      )
    ).records[0].Id;
    paymentTypeIds.push(paymentTypeId);
  });

  const paymentTypesDeleteResponse = await conn.destroy('OrderApi__Custom_Payment_Type__c', paymentTypeIds);
  paymentTypesDeleteResponse.forEach((response) => {
    expect(response.success).toEqual(true);
  });
});

Then(`User continues to paymentInfo and verfies the instructions of the payment types created`, async () => {
  await addressComponent.click(await addressComponent.buttonContinue);
  expect(await eventCheckoutPage.isDisplayed(await eventCheckoutPage.processPayment)).toBe(true);

  const paymentTypeNamesList = (await browser.sharedStore.get('paymentTypeNames')) as string[];
  for (let i = 0; i < paymentTypeNamesList.length; i += 1) {
    eventCheckoutPage.paymentType = paymentTypeNamesList[i];
    await eventCheckoutPage.click(await eventCheckoutPage.paymentTypeLink);
    expect(await eventCheckoutPage.getAttributeValue(await eventCheckoutPage.paymentTypeLink, 'class')).toContain(
      'slds-active',
    );

    const paymentTypeDetails = (
      await conn.query<Fields$OrderApi__Custom_Payment_Type__c>(
        `SELECT Id, OrderApi__Instructions__c FROM OrderApi__Custom_Payment_Type__c WHERE Name = '${paymentTypeNamesList[i]}'`,
      )
    ).records[0];

    const actualPaymentInstruction = await eventCheckoutPage.getText(await eventCheckoutPage.creditCompInstructions);

    expect(actualPaymentInstruction).toEqual(paymentTypeDetails.OrderApi__Instructions__c);
  }
});
