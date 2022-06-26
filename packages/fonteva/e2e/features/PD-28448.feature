@REQ_PD-28448
Feature: Dues Total on Term is increasing whenever there is an edit to the related subscription line
	#h2. Details
	#
	#Dues Total on Term is increasing whenever there is an edit to the related subscription line.
	#
	#GCO
	#
	#[21winter@fondash.io|mailto:21winter@fondash.io] / Fonteva2021
	#
	#ex: The Brain - [https://gco9kjpim.lightning.force.com/lightning/r/Contact/0035Y00003jZ8TMQA0/view|https://gco9kjpim.lightning.force.com/lightning/r/Contact/0035Y00003jZ8TMQA0/view|smart-link] 
	#
	#h2. Steps to Reproduce
	#
	#* Navigate to a contact record 
	#* Click on Rapid Order Entry button
	#* Add any membership item to the order
	#* Click Go and continue to Apply Payment page
	#* Complete payment for the order
	#* Navigate to the Sales Order Line for the above order and select the newly created subscription record from the related list
	#* Select the term record from the related list and verify the Dues Total field (should be equal the amount you paid)
	#* Go to related subscription line from the Subscription record
	#* Edit the record and click save without making any changes
	#* Edit the record again and click Save
	#* Go back to term record and Verify the Dues Total field
	#
	#Fast forward to 2:15 in recording to see actual issue:
	#[https://fonteva.zoom.us/rec/share/IeFChWPUkfvX7EvRCCXpt3ErDBuFDk7jcpiGeEczhcSBHCj6Y9BPF9EZqEK0fY0x.d4gIxJ4VHfrwQne6|https://fonteva.zoom.us/rec/share/IeFChWPUkfvX7EvRCCXpt3ErDBuFDk7jcpiGeEczhcSBHCj6Y9BPF9EZqEK0fY0x.d4gIxJ4VHfrwQne6]
	#
	#h2. Expected Results
	#
	#Dues Total should be the amount paid
	#
	#h2. Actual Results
	#
	#Dues Total increases each time the user edits the subscription line
	#
	#h2. Business Justification
	#
	#This affects APNA because they send out Dues total in emails to their customers. Will result in wrong amounts reflected.

	#Tests h2. Details
	#
	#Dues Total on Term is increasing whenever there is an edit to the related subscription line.
	#
	#GCO
	#
	#[21winter@fondash.io|mailto:21winter@fondash.io] / Fonteva2021
	#
	#ex: The Brain - [https://gco9kjpim.lightning.force.com/lightning/r/Contact/0035Y00003jZ8TMQA0/view|https://gco9kjpim.lightning.force.com/lightning/r/Contact/0035Y00003jZ8TMQA0/view|smart-link] 
	#
	#h2. Steps to Reproduce
	#
	#* Navigate to a contact record 
	#* Click on Rapid Order Entry button
	#* Add any membership item to the order
	#* Click Go and continue to Apply Payment page
	#* Complete payment for the order
	#* Navigate to the Sales Order Line for the above order and select the newly created subscription record from the related list
	#* Select the term record from the related list and verify the Dues Total field (should be equal the amount you paid)
	#* Go to related subscription line from the Subscription record
	#* Edit the record and click save without making any changes
	#* Edit the record again and click Save
	#* Go back to term record and Verify the Dues Total field
	#
	#Fast forward to 2:15 in recording to see actual issue:
	#[https://fonteva.zoom.us/rec/share/IeFChWPUkfvX7EvRCCXpt3ErDBuFDk7jcpiGeEczhcSBHCj6Y9BPF9EZqEK0fY0x.d4gIxJ4VHfrwQne6|https://fonteva.zoom.us/rec/share/IeFChWPUkfvX7EvRCCXpt3ErDBuFDk7jcpiGeEczhcSBHCj6Y9BPF9EZqEK0fY0x.d4gIxJ4VHfrwQne6]
	#
	#h2. Expected Results
	#
	#Dues Total should be the amount paid
	#
	#h2. Actual Results
	#
	#Dues Total increases each time the user edits the subscription line
	#
	#h2. Business Justification
	#
	#This affects APNA because they send out Dues total in emails to their customers. Will result in wrong amounts reflected.
	@REQ_PD-28448 @TEST_PD-28520 @regression @21Winter @22Winter @sophiya
	Scenario: Test Dues Total on Term is increasing whenever there is an edit to the related subscription line
		Given User will select "Daniela Brown" contact
		When User opens the Rapid Order Entry page from contact
		And User should be able to add "AutoCalenderPlan" item on rapid order entry
		And User navigate to "apply payment" page for "AutoCalenderPlan" item from rapid order entry
		And User should be able to apply payment for "AutoCalenderPlan" item using "Credit Card" payment on apply payment page
		Then User verifies the total dues in term record
		And User edits and save the subscription line item
		And User verifies the total dues in term record
