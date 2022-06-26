@REQ_PD-27760
Feature: Multi SO/Multi Invoice - When Enable Guest Save Payment = false, checkbox to opt in to save payment method still appears
	#*Reproduced by* Effie Zhang in 2019.1.0.18
	#
	#*Reference Case#*[*00021672*|https://fonteva.lightning.force.com/lightning/r/Case/5003A00000zZ1QFQA0/view]
	#
	#This bug is only for GUEST USER. The setting is not related to the logged-in users.
	#
	#*Description:*
	#
	#When *Enable Guest Save Payment = false* on the store record, checkbox to opt in to save payment method still appears in some scenarios.
	#
	#We have fixed the scenarios for proforma invoice guest checkout (aka STORE CHECKOUT) and guest checkout for 1 SO in {color:#3e3e3c}T1-3088{color}.
	#
	#However, in the following scenarios, when {color:#3e3e3c}Enable Guest Save Payment = false in Store, "{color}Would you like to save this payment method for future use?" checkbox still shows up when checking out as a guest. I'm attaching examples from my QA org:
	#
	#* *COMBO PAYMENT PAGE*
	#** {color:#3e3e3c}Scenario 1: {color}Multiple SO - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCeT,a1J4T000000bCdp |https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCeT,a1J4T000000bCdp%20]
	#** {color:#3e3e3c}Scenario 2: {color}SO + invoice - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCdp,a124T0000005jOv|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCdp,a124T0000005jOv]
	#* *INVOICE PAYMENT PAGE*
	#** {color:#3e3e3c}Scenario 3: {color}Multiple invoices - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a124T0000005T2Y,a124T0000005jOv|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a124T0000005T2Y,a124T0000005jOv]
	#** {color:#3e3e3c}Scenario 4: {color}1 invoice via invoice checkout - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/Invoice_checkout_guest/a124T0000005cAb|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/Invoice_checkout_guest/a124T0000005cAb]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* *Go to Store Record > set Enable Guest Save Payment = false*
	#* Have some unpaid SO and invoices created in the system
	#* Go to incognito to pay as a guest (example URL from my QA test included in description)
	#** *Scenario 1*: Multiple SO (SO type Receipt)
	#*** If we use the same URL as a proforma but pass multiple sales order id's, we still see a save payment checkbox on this checkout screen
	#** *Scenario 2*: SO + invoice  (SO type Receipt + SO type Invoice)
	#*** {color:#3e3e3c}If we use the same URL as a proforma but pass 1 SO and 1 Invoice, we still see the save payment checkbox on this checkout screen{color}
	#** *Scenario 3*: Multiple invoices  (SO type Invoice)
	#*** If we use the same URL as a proforma but pass multiple Invoices, we still see the save payment checkbox on this checkout screen
	#** Scenario 4: 1 invoice via invoice checkout  (SO type Invoice)
	#*** still showing save payment checkbox in the guest invoice checkout screen
	#
	#*Actual Results:*
	#
	#{color:#3e3e3c}"Would you like to save this payment method for future use?" checkbox is still visible{color}
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}"Would you like to save this payment method for future use?" checkbox should not show when checking out as a guest if Enable Guest Save Payment = false{color}
	#
	#
	#
	#*PM NOTE:*
	#
	#* We can use the order summary builder to go to the right checkout page rather than populating the URL with Order Ids.
	#* FIX IS ONLY FOR GUEST USERS\! make sure we dont make changes for logged-in users.
	#* We have fixed this issue for Store Checkout where you can pay single SO
	#Old bug ref:[https://fonteva.atlassian.net/browse/PD-22582|https://fonteva.atlassian.net/browse/PD-22582|smart-link]  We have fixed the scenario for proforma invoice and 1 SO in the above ticket.
	#* See the Checkout Pages and what can be paid
	#[https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit#gid=0|https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit#gid=0|smart-link]

	#Tests *Reproduced by* Effie Zhang in 2019.1.0.18
	#
	#*Reference Case#*[*00021672*|https://fonteva.lightning.force.com/lightning/r/Case/5003A00000zZ1QFQA0/view]
	#
	#This bug is only for GUEST USER. The setting is not related to the logged-in users.
	#
	#*Description:*
	#
	#When *Enable Guest Save Payment = false* on the store record, checkbox to opt in to save payment method still appears in some scenarios.
	#
	#We have fixed the scenarios for proforma invoice guest checkout (aka STORE CHECKOUT) and guest checkout for 1 SO in {color:#3e3e3c}T1-3088{color}.
	#
	#However, in the following scenarios, when {color:#3e3e3c}Enable Guest Save Payment = false in Store, "{color}Would you like to save this payment method for future use?" checkbox still shows up when checking out as a guest. I'm attaching examples from my QA org:
	#
	#* *COMBO PAYMENT PAGE*
	#** {color:#3e3e3c}Scenario 1: {color}Multiple SO - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCeT,a1J4T000000bCdp |https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCeT,a1J4T000000bCdp%20]
	#** {color:#3e3e3c}Scenario 2: {color}SO + invoice - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCdp,a124T0000005jOv|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a1J4T000000bCdp,a124T0000005jOv]
	#* *INVOICE PAYMENT PAGE*
	#** {color:#3e3e3c}Scenario 3: {color}Multiple invoices - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a124T0000005T2Y,a124T0000005jOv|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/checkout/a124T0000005T2Y,a124T0000005jOv]
	#** {color:#3e3e3c}Scenario 4: {color}1 invoice via invoice checkout - [https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/Invoice_checkout_guest/a124T0000005cAb|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/s/store#/store/Invoice_checkout_guest/a124T0000005cAb]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* *Go to Store Record > set Enable Guest Save Payment = false*
	#* Have some unpaid SO and invoices created in the system
	#* Go to incognito to pay as a guest (example URL from my QA test included in description)
	#** *Scenario 1*: Multiple SO (SO type Receipt)
	#*** If we use the same URL as a proforma but pass multiple sales order id's, we still see a save payment checkbox on this checkout screen
	#** *Scenario 2*: SO + invoice  (SO type Receipt + SO type Invoice)
	#*** {color:#3e3e3c}If we use the same URL as a proforma but pass 1 SO and 1 Invoice, we still see the save payment checkbox on this checkout screen{color}
	#** *Scenario 3*: Multiple invoices  (SO type Invoice)
	#*** If we use the same URL as a proforma but pass multiple Invoices, we still see the save payment checkbox on this checkout screen
	#** Scenario 4: 1 invoice via invoice checkout  (SO type Invoice)
	#*** still showing save payment checkbox in the guest invoice checkout screen
	#
	#*Actual Results:*
	#
	#{color:#3e3e3c}"Would you like to save this payment method for future use?" checkbox is still visible{color}
	#
	#*Expected Results:*
	#
	#{color:#3e3e3c}"Would you like to save this payment method for future use?" checkbox should not show when checking out as a guest if Enable Guest Save Payment = false{color}
	#
	#
	#
	#*PM NOTE:*
	#
	#* We can use the order summary builder to go to the right checkout page rather than populating the URL with Order Ids.
	#* FIX IS ONLY FOR GUEST USERS\! make sure we dont make changes for logged-in users.
	#* We have fixed this issue for Store Checkout where you can pay single SO
	#Old bug ref:[https://fonteva.atlassian.net/browse/PD-22582|https://fonteva.atlassian.net/browse/PD-22582|smart-link]  We have fixed the scenario for proforma invoice and 1 SO in the above ticket.
	#* See the Checkout Pages and what can be paid
	#[https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit#gid=0|https://docs.google.com/spreadsheets/d/10B1L5V8c6mQ7giiAjtjxJXp5yq2mYlmNKPmyT5MwBkE/edit#gid=0|smart-link]
	@TEST_PD-28246 @REQ_PD-27760 @regression @21Winter @22Winter @ngunda
	Scenario: Test Multi SO/Multi Invoice - When Enable Guest Save Payment = false, checkbox to opt in to save payment method still appears
		Given User creates salesOrders with information provided below:
			| Contact      | Account            | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName  | Qty |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Invoice       | Simple Invoice | AutoItem1 | 1   |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Invoice       | Simple Invoice | AutoItem2 | 1   |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Receipt       | Simple Receipt | AutoItem1 | 1   |
			| Max Foxworth | Foxworth Household | Foundation    | Contact | Receipt       | Simple Receipt | AutoItem2 | 1   |
		When User marks the created orders as ready for payment
		Then User Opens the Portal combo checkout page and verifies the save payment checkbox is not displayed for combos below:
			| ComboType           |
			| Receipt             |
			| Invoice             |
			| Receipt and Invoice |
			| Multiple Invoice    |
			| Multiple Receipt    |
