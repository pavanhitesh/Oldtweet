@REQ_PD-28104
Feature: PENDING Query - The wrong payment gateway used for new payment method verification
	#h2. Details
	#
	#The wrong payment gateway used for new payment method verification
	#
	#h2. Steps to Reproduce
	#
	#* Create a Business Group
	#* Create two Payments Gateways under the Business Group say Gateway 1 and Gateway 2
	#** Steps to create a payment gateway [https://docs.fonteva.com/user/Configure-a-Test-Payment-Gateway.1943797811.html|https://docs.fonteva.com/user/Configure-a-Test-Payment-Gateway.1943797811.html|smart-link] 
	#* Set default gateway lookup as Gateway 2 on the business group
	#* Create a Store with Default Gateway 2
	#* *_Add Gateway 2 as a payment gateway for a payment type (eg Credit Card)_*
	#* Create an item and add as a catalog item to the store
	#* Go to contact
	#* login to the community as a user
	#* Navigate to the portal store 
	#* Add an item to the cart and 
	#* Complete purchasing the item using credit card
	#* Validate the payment gateway field on epayment and receipt records
	#
	#h2. Expected Results
	#
	#* The verification request ( £1 ) goes to Gateway 2
	#* The payment gateway should be Gateway 2 on the epayment and receipt records
	#
	#h2. Actual Results
	#
	#* The verification request ( £1 ) goes to Gateway 1
	#* The payment gateway is Gateway 1 on the epayment and receipt records
	#
	#
	#
	#h2. PM NOTE:
	#
	#The issue is likely to be on e-Payment creation when the customer clicks pay. BC e-payment creates the receipt if payment is successful
	#
	#We should use the payment gateway from the “Payment Type“ object which is a related list under the store.
	#
	#*NOTE TO QA:*
	#
	#We need to create 1 more payment gateway under the BG called “Foundation“ and use the existing flows have.
	#
	#Creating Payment gateway part is manul, we do not have a rest call.
	#
	#h2. Business Justification
	#
	#When we have 2 payment gateways configured, the system is using the first payment gateway added to the system for sending the £1 verification request rather than the default gateway defined on the business group

	#Tests h2. Details
	#
	#The wrong payment gateway used for new payment method verification
	#
	#h2. Steps to Reproduce
	#
	#* Create a Business Group
	#* Create two Payments Gateways under the Business Group say Gateway 1 and Gateway 2
	#** Steps to create a payment gateway [https://docs.fonteva.com/user/Configure-a-Test-Payment-Gateway.1943797811.html|https://docs.fonteva.com/user/Configure-a-Test-Payment-Gateway.1943797811.html|smart-link] 
	#* Set default gateway lookup as Gateway 2 on the business group
	#* Create a Store with Default Gateway 2
	#* *_Add Gateway 2 as a payment gateway for a payment type (eg Credit Card)_*
	#* Create an item and add as a catalog item to the store
	#* Go to contact
	#* login to the community as a user
	#* Navigate to the portal store 
	#* Add an item to the cart and 
	#* Complete purchasing the item using credit card
	#* Validate the payment gateway field on epayment and receipt records
	#
	#h2. Expected Results
	#
	#* The verification request ( £1 ) goes to Gateway 2
	#* The payment gateway should be Gateway 2 on the epayment and receipt records
	#
	#h2. Actual Results
	#
	#* The verification request ( £1 ) goes to Gateway 1
	#* The payment gateway is Gateway 1 on the epayment and receipt records
	#
	#
	#
	#h2. PM NOTE:
	#
	#The issue is likely to be on e-Payment creation when the customer clicks pay. BC e-payment creates the receipt if payment is successful
	#
	#We should use the payment gateway from the “Payment Type“ object which is a related list under the store.
	#
	#*NOTE TO QA:*
	#
	#We need to create 1 more payment gateway under the BG called “Foundation“ and use the existing flows have.
	#
	#Creating Payment gateway part is manul, we do not have a rest call.
	#
	#h2. Business Justification
	#
	#When we have 2 payment gateways configured, the system is using the first payment gateway added to the system for sending the £1 verification request rather than the default gateway defined on the business group
	@TEST_PD-28845 @REQ_PD-28104 @21Winter @22Winter @regression @anitha
	Scenario: Test PENDING Query - The wrong payment gateway used for new payment method verification
		Given User navigate to community Portal page with "ettabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoItem1" item with quantity "1" on Store
		And User should click on the checkout button
		When User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message
		Then User should see "TFoundation Payment Gateway" on Payment Gateway field in receipt and epayment record
