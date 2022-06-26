@REQ_PD-28493
Feature: When viewing financial documents for pre-20Spring proformas in an upgraded environment, Subtotal and Total are shown as $0
	#h2. Details
	#When viewing financial documents for pre-20Spring proformas in an upgraded environment, Subtotal and Total are shown as $0
	#h2. Steps to Reproduce
	#1. In a 21Winter org, deactivate the "Order/Invoice Merge" custom setting according to these steps: https://fonteva.atlassian.net/wiki/spaces/FT/pages/2149941351/How+to+Create+SO+Before+Order+Smash+for+Testing+Purpose
	#2. From a contact, open ROE, add a generic item, and send proforma
	#3. From the resulting Sales Order, click View Document and note that Subtotal and Total are $0 even though SO and SOL have the correct value populated on those fields.
	#4. Re-activate the "Order/Invoice Merge" custom setting
	#5. Apply payment to the proforma
	#
	#Screen recording: https://fonteva.zoom.us/rec/share/DSLPYA5xsCbnvb2SFsCb7_8NdKFV73t4t0veK2WwJJ4NBNz8CQr6jEqLvodCpz5C.aYBxtyd6NtSx0v8t
	#h2. Expected Results
	#Financial Documents in post-20Spring environments show correct Subtotal and Total values for pre-20spring orders
	#h2. Actual Results
	#Financial Documents (Sales Order and Receipt Order page) show Subtotal and Total as $0, even though those fields are correctly populated on the SO and SOL
	#h2. Business Justification
	#Impacts every customer who is upgrading from pre-20Spring.

	#Tests h2. Details
	#When viewing financial documents for pre-20Spring proformas in an upgraded environment, Subtotal and Total are shown as $0
	#h2. Steps to Reproduce
	#1. In a 21Winter org, deactivate the "Order/Invoice Merge" custom setting according to these steps: https://fonteva.atlassian.net/wiki/spaces/FT/pages/2149941351/How+to+Create+SO+Before+Order+Smash+for+Testing+Purpose
	#2. From a contact, open ROE, add a generic item, and send proforma
	#3. From the resulting Sales Order, click View Document and note that Subtotal and Total are $0 even though SO and SOL have the correct value populated on those fields.
	#4. Re-activate the "Order/Invoice Merge" custom setting
	#5. Apply payment to the proforma
	#
	#Screen recording: https://fonteva.zoom.us/rec/share/DSLPYA5xsCbnvb2SFsCb7_8NdKFV73t4t0veK2WwJJ4NBNz8CQr6jEqLvodCpz5C.aYBxtyd6NtSx0v8t
	#h2. Expected Results
	#Financial Documents in post-20Spring environments show correct Subtotal and Total values for pre-20spring orders
	#h2. Actual Results
	#Financial Documents (Sales Order and Receipt Order page) show Subtotal and Total as $0, even though those fields are correctly populated on the SO and SOL
	#h2. Business Justification
	#Impacts every customer who is upgrading from pre-20Spring.
	@TEST_PD-28941 @REQ_PD-28493 @21Winter @22Winter @Santosh @regression
	Scenario: Test When viewing financial documents for pre-20Spring proformas in an upgraded environment, Subtotal and Total are shown as $0
		Given User will select "Bob Kelley" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoItem2" item on rapid order entry
		When User selects "Proforma Invoice" as payment method and proceeds further
		Then User exits to sales order and verifies the subTotal and Total amount in view document
