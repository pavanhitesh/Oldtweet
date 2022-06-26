@REQ_PD-29152
Feature: Ability to pay proforma invoice when the order has been cancelled
	#h2. Details
	#Customers are able to apply payment using a link from a proforma email associated with a cancelled sales order - this should be restricted.
	#
	#This issue has been replicated in the client org and fonteva demo orgs.
	#h2. Steps to Reproduce
	#Steps to reproduce/test:
	#1) Create order and send proforma invoice
	#2) Cancel/void order from step 1.
	#3) Validate that the customer can no longer pay the proforma from the email link
	#
	#Video of replication: https://fonteva.zoom.us/rec/share/2Gf4aCmw5W67iI-lx5-w0JIXJa0qufxJF-tS3crr4sOomx-u2nXxACeLmfCP3F3w.UTdU6TrsdsdelZQf
	#h2. Expected Results
	#customer should not be able to  pay proforma invoice on a cancelled order
	#h2. Actual Results
	#customer can pay proforma invoice on a cancelled order
	#h2. Business Justification
	#This will create financial issues if a client pays for an order that has been cancelled. The flowdown issues are time consuming and our clients will need to refund orders.

	#Tests h2. Details
	#Customers are able to apply payment using a link from a proforma email associated with a cancelled sales order - this should be restricted.
	#
	#This issue has been replicated in the client org and fonteva demo orgs.
	#h2. Steps to Reproduce
	#Steps to reproduce/test:
	#1) Create order and send proforma invoice
	#2) Cancel/void order from step 1.
	#3) Validate that the customer can no longer pay the proforma from the email link
	#
	#Video of replication: https://fonteva.zoom.us/rec/share/2Gf4aCmw5W67iI-lx5-w0JIXJa0qufxJF-tS3crr4sOomx-u2nXxACeLmfCP3F3w.UTdU6TrsdsdelZQf
	#h2. Expected Results
	#customer should not be able to  pay proforma invoice on a cancelled order
	#h2. Actual Results
	#customer can pay proforma invoice on a cancelled order
	#h2. Business Justification
	#This will create financial issues if a client pays for an order that has been cancelled. The flowdown issues are time consuming and our clients will need to refund orders.
	@REQ_PD-29152 @TEST_PD-29522 @regression @21Winter @22Winter @ngunda
	Scenario: Test Ability to pay proforma invoice when the order has been cancelled
		Given User will select "Max Foxworth" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem2" item on rapid order entry
		When User selects "Proforma Invoice" as payment method and proceeds further
		And User sends email with payment link and opens the payment link
		When User makes the Salesorder void or cancelled
		Then User verifies that voided or cancelled orders cannot be paid by logging in with username "Maxfoxworth@mailinator.com" and password "705Fonteva"
