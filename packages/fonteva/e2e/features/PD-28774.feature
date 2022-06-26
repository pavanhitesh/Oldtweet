@REQ_PD-28774
Feature: The payment types are not showing the correct instructions on the checkout page.
	#h2. Details
	#The Payment Types with the same Payment Type Template seem to be displaying the same instructions.
	#h2. Steps to Reproduce
	#1. Go to Store and in the Custom Payment Types create a couple of payment types and set the Payment Type Template the same, for example us the template: Offline
	#
	#2. Make sure to write different instructions for each payment type.
	#
	#3. Go to an Event and click on the Event URL
	#
	#4. Register as a guest and add any ticket
	#
	#5. Once on the Choose a Payment Method page select one of the payment types you create and notice the instructions.
	#
	#6. While on the same page choose another one of your custom payment types and see the instructions are the exact same even though you set them different in the backend.
	#
	#GCO used to test:
	#21winter@fondash.io  /  Fonteva2021
	#
	#Recording of issue: https://drive.google.com/file/d/1adASuwL3atFKlXHdmTAhhMrU9xjIurh-/view?usp=sharing
	#h2. Expected Results
	#The instructions should be specific to each custom payment type.
	#h2. Actual Results
	#The payment types are not showing the correct instructions in the checkout page as what was configured in the backend.
	#h2. Business Justification
	#This is causing customers confusion on how to pay.

	#Tests h2. Details
	#The Payment Types with the same Payment Type Template seem to be displaying the same instructions.
	#h2. Steps to Reproduce
	#1. Go to Store and in the Custom Payment Types create a couple of payment types and set the Payment Type Template the same, for example us the template: Offline
	#
	#2. Make sure to write different instructions for each payment type.
	#
	#3. Go to an Event and click on the Event URL
	#
	#4. Register as a guest and add any ticket
	#
	#5. Once on the Choose a Payment Method page select one of the payment types you create and notice the instructions.
	#
	#6. While on the same page choose another one of your custom payment types and see the instructions are the exact same even though you set them different in the backend.
	#
	#GCO used to test:
	#21winter@fondash.io  /  Fonteva2021
	#
	#Recording of issue: https://drive.google.com/file/d/1adASuwL3atFKlXHdmTAhhMrU9xjIurh-/view?usp=sharing
	#h2. Expected Results
	#The instructions should be specific to each custom payment type.
	#h2. Actual Results
	#The payment types are not showing the correct instructions in the checkout page as what was configured in the backend.
	#h2. Business Justification
	#This is causing customers confusion on how to pay.
	@TEST_PD-29246 @REQ_PD-28774 @regression @21Winter @22Winter @ngunda
	Scenario: Test The payment types are not showing the correct instructions on the checkout page.
		Given User creates payment types with below information:
			| PaymentTypeName         | IsEnabled | Store            | PaymentTypeTemplate | Instructions                           | DisplayOnBackEndCheckout | DisplayOnFrontEndCheckout | DisplayOrder |
			| Delete_AutoPaymentType1 | True      | Foundation Store | Credit_Card         | Delete_AutoPaymentType1 - Instructions | True                     | True                      | 2            |
			| Delete_AutoPaymentType2 | True      | Foundation Store | Credit_Card         | Delete_AutoPaymentType2 - Instructions | True                     | True                      | 2            |
		When User navigate to community Portal page
		When User selects event "AutoEvent1" and event type "MultiTicket" on LT portal
		And User register for "AutoTicket" ticket with 1 quantity and navigate to "session" page as "Guest"
		And User selects "NA" sessions on agenda page and navigate to "checkout" page
		Then User Should add the new address as name "Auto Test Address" , type "Home" and address "123 Melrose Street, Brooklyn, NY, USA"
		Then User continues to paymentInfo and verfies the instructions of the payment types created
