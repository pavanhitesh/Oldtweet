@REQ_PD-28759
Feature: Calculate Billing Details field on Sales Order is not checked when an order is completed in the community, resulting in blank "To:" section in financial documents
	#h2. Details
	#
	#Calculate Billing Details field on Sales Order is not checked when an order is completed in the community, resulting in blank "To:" section in financial documents
	#
	#This is possibly the same issue as [https://fonteva.atlassian.net/browse/PD-26656|https://fonteva.atlassian.net/browse/PD-26656] and [https://fonteva.atlassian.net/browse/PD-26657,|https://fonteva.atlassian.net/browse/PD-26657,] but I have reproduced the bug behavior in 21Winter.0.10 and 20Spring.1.19 GCOs with the custom metadata for updateBillingAddress configured and enabled, per this page of release notes - [https://docs.fonteva.com/releases/Update-Billing-Address-Metadata.2862416016.html|https://docs.fonteva.com/releases/Update-Billing-Address-Metadata.2862416016.html].
	#
	#h2. Steps to Reproduce
	#
	#1. Log into community as a contact with Mailing Address populated but no Known Addresses
	#2. Navigate to the Store and purchase a generic item without shipping or tax
	#3. Complete payment with Credit Card without entering an address
	#
	#Screen recording: [https://fonteva.zoom.us/rec/share/PtOcK3QKV79SKRqczFUAnfqI1M5r6XxxaNJU7WVnUnuifY1LZEnZyplJnxzR1lyP.EwowSaPiDEtQ_Ryq|https://fonteva.zoom.us/rec/share/PtOcK3QKV79SKRqczFUAnfqI1M5r6XxxaNJU7WVnUnuifY1LZEnZyplJnxzR1lyP.EwowSaPiDEtQ_Ryq]
	#
	#h2. Expected Results
	#
	#Sales Order's Calculate Billing Details field is checked. Billing Contact and Address fields are populated on Sales Order and Receipt.
	#
	#* The billing contact text field on the SO should be populated with whoever is paying the order (Contact lookup on the receipt).
	#* Remember maybe Contact A, pays Contact B’s Sales Order, on that case
	#** SO Contact lookup = Contact A
	#** SO Billing Contact (Text field) = Contact B
	#** Receipt contact lookup = Contact B
	#
	#h2. Actual Results
	#
	#Sales Order's Calculate Billing Details field is unchecked, resulting in the Billing Contact and Billing Address fields not being populated. As a result, Billing Contact and Billing Address fields are also missing from Receipt. Financial documents' "To: " sections are blank
	#
	#h2. Business Justification
	#
	#Missing data from financial records and member-facing documents.

	#Tests h2. Details
	#Calculate Billing Details field on Sales Order is not checked when an order is completed in the community, resulting in blank "To:" section in financial documents
	#
	#This is possibly the same issue as https://fonteva.atlassian.net/browse/PD-26656 and https://fonteva.atlassian.net/browse/PD-26657, but I have reproduced the bug behavior in 21Winter.0.10 and 20Spring.1.19 GCOs with the custom metadata for updateBillingAddress configured and enabled, per this page of release notes - https://docs.fonteva.com/releases/Update-Billing-Address-Metadata.2862416016.html.
	#h2. Steps to Reproduce
	#1. Log into community as a contact with Mailing Address populated but no Known Addresses
	#2. Navigate to the Store and purchase a generic item without shipping or tax
	#3. Complete payment with Credit Card without entering an address
	#
	#Screen recording: https://fonteva.zoom.us/rec/share/PtOcK3QKV79SKRqczFUAnfqI1M5r6XxxaNJU7WVnUnuifY1LZEnZyplJnxzR1lyP.EwowSaPiDEtQ_Ryq
	#h2. Expected Results
	#Sales Order's Calculate Billing Details field is checked. Billing Contact and Address fields are populated on Sales Order and Receipt.
	#h2. Actual Results
	#Sales Order's Calculate Billing Details field is unchecked, resulting in the Billing Contact and Billing Address fields not being populated. As a result, Billing Contact and Billing Address fields are also missing from Receipt. Financial documents' "To: " sections are blank
	#h2. Business Justification
	#Missing data from financial records and member-facing documents.
	@TEST_PD-28893 @REQ_PD-28759 @21Winter @22Winter @ngunda @regression
	Scenario: (Paying Self Order) - Test Calculate Billing Details field on Sales Order is not checked when an order is completed in the community, resulting in blank "To:" section in financial documents
		Given User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoItem2" item with quantity "1" on store
		And User should click on the checkout button
		When User successfully pays for the order using credit card
		And User should see the "receipt" created confirmation message
		Then user verifies the billing contact is populated as "Max Foxworth" on SalesOrder and receipt created by "same user"

	@TEST_PD-29206 @REQ_PD-28759 @21Winter @22Winter @ngunda @regression
	Scenario: (Paying Others Orders) - Test Calculate Billing Details field on Sales Order is not checked when an order is completed in the community, resulting in blank "To:" section in financial documents
		Given User creates salesOrders with information provided below:
			| Contact      | Account            | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName  | Qty |
			| Eva Foxworth | Foxworth Household | Foundation    | Account | Invoice       | Simple Invoice | AutoItem2 | 1   |
		And User marks the created orders as ready for payment
		When User navigate to community Portal page with "maxfoxworth@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User opens checkout page for the order created and continue to payment Section
		And User successfully pays for the order using credit card
		Then user verifies the billing contact is populated as "Max Foxworth" on SalesOrder and receipt created by "other user"
