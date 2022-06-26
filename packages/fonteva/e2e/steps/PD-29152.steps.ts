import { When, Before, After } from '@cucumber/cucumber';
import { checkoutPage } from '../../pages/portal/checkout.page';
import { Fields$OrderApi__Sales_Order__c } from '../../fonteva-schema';
import { conn } from '../../shared/helpers/force.helper';
import { loginPage } from '../../pages/salesforce/login.page';
import { portalLoginPage } from '../../pages/portal/login.page';

const localSharedData: { [key: string]: string } = {};

Before({ tags: '@TEST_PD-29522' }, async () => {
  await loginPage.open('/');
  await loginPage.login();
});

After({ tags: '@TEST_PD-29522' }, async () => {
  const salesOrderDeleted = await conn.destroy('OrderApi__Sales_Order__c', localSharedData.salesOrderId as string);
  expect(salesOrderDeleted.success).toEqual(true);
});

When('User makes the Salesorder void or cancelled', async () => {
  localSharedData.salesOrderId = (
    await conn.query<Fields$OrderApi__Sales_Order__c>(
      `SELECT Id FROM OrderApi__Sales_Order__c WHERE Name = '${await browser.sharedStore.get('SalesOrderNumber')}'`,
    )
  ).records[0].Id;
  const soVoidResponse = await conn.tooling.executeAnonymous(`
  OrderApi__Sales_Order__c voidSO = [Select OrderApi__Is_Cancelled__c, OrderApi__Is_Voided__c from OrderApi__Sales_Order__c Where Id = '${localSharedData.salesOrderId}'];
  voidSO.OrderApi__Is_Cancelled__c = true;
  voidSO.OrderApi__Is_Voided__c = true;
  update voidSO;`);
  expect(soVoidResponse.success).toEqual(true);
});

When(
  `User verifies that voided or cancelled orders cannot be paid by logging in with username {string} and password {string}`,
  async (username, password) => {
    await portalLoginPage.click(await portalLoginPage.alreadyMemberLoginBtn);
    await portalLoginPage.portalLogin(username, password);
    await checkoutPage.waitForPresence(await checkoutPage.invalidOrderMessage);
    const errorMessage = await checkoutPage.getText(await checkoutPage.invalidOrderMessage);
    let orderVoided: boolean;
    if (
      errorMessage === `In order to process payment, related SalesOrder must be closed.` ||
      errorMessage === `This Sales Order is voided/cancelled.`
    ) {
      orderVoided = true;
    } else {
      orderVoided = false;
    }
    expect(orderVoided).toBe(true);
  },
);
