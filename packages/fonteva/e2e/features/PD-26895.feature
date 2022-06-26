@REQ_PD-26895
Feature: Entity driving the address on Sales Order
	#*Case Reporter* Harisha Kodali
	#
	#*Customer* Healthcare Financial Management Association
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.36,20Spring.1.5
	#
	#*Reference Case#* [00027763|https://fonteva.my.salesforce.com/5004V000012zxwrQAA]
	#
	#*Description:*
	#
	#On the creation of sales order, the entity was driving the address fields, but on the update of entity it does not update the following fields
	#
	#* 1. Billing contact
	#* 2. Billing Street
	#* 3. Billing city
	#* 4. Billing state
	#* 5. Billing Postal Code
	#* 6. Billing country
	#* 7. Shipping contact
	#* 8. Shipping Street
	#* 9. Shipping city
	#* 10. Shipping state
	#* 11. Shipping postal code
	#* 12. Shipping country
	#
	#*Steps to Reproduce:*
	#
	## Navigate to the Sales Order object and click on the New button (BE)
	## Select Entity Account and populate an account information
	## Save the record
	## Verify the address was populated
	## Now change the entity to Contact and verify if the address was updated.
	#
	#*Actual Results:*
	#
	#The address does not update regardless of the change:
	#
	#* contact entity, change one contact to another
	#* contact entity, changes to the account entity
	#* account entity, change to contact
	#
	#*Expected Results / Acceptance Criteria*
	#
	#When one of the following changed:
	#
	#* Contact lookup on SO
	#* Account lookup on SO
	#* Entity Picklist on SO
	#
	#The system should re-calculate the address fields on the Sales Order
	#
	#*PM Note:*
	#
	#* The system already provides the address on the insert of an order, {color:#FF5630}we just need to make sure to call the same logic when one of the above changes.{color}
	#* Make sure the define the criteria to only fire the trigger when related fields changes. {color:#FF5630}We dont want to introduce performance issues with unnecessary DMLs{color}
	#
	#*Business Justification:*
	#
	#Ability to change/update the entity when the Sales Order is already created.
	#
	#*CS Note:*
	#This issue is not reproducible in 20 Spring.15
	#
	#Estimate
	#
	#QA: 24h

	#Tests *Case Reporter* Harisha Kodali
	#
	#*Customer* Healthcare Financial Management Association
	#
	#*Reproduced by* Ewa Imtiaz in 2019.1.0.36,20Spring.1.5
	#
	#*Reference Case#* [00027763|https://fonteva.my.salesforce.com/5004V000012zxwrQAA]
	#
	#*Description:*
	#
	#On the creation of sales order, the entity was driving the address fields, but on the update of entity it does not update the following fields
	#
	#* 1. Billing contact
	#* 2. Billing Street
	#* 3. Billing city
	#* 4. Billing state
	#* 5. Billing Postal Code
	#* 6. Billing country
	#* 7. Shipping contact
	#* 8. Shipping Street
	#* 9. Shipping city
	#* 10. Shipping state
	#* 11. Shipping postal code
	#* 12. Shipping country
	#
	#*Steps to Reproduce:*
	#
	## Navigate to the Sales Order object and click on the New button (BE)
	## Select Entity Account and populate an account information
	## Save the record
	## Verify the address was populated
	## Now change the entity to Contact and verify if the address was updated.
	#
	#*Actual Results:*
	#
	#The address does not update regardless of the change:
	#
	#* contact entity, change one contact to another
	#* contact entity, changes to the account entity
	#* account entity, change to contact
	#
	#*Expected Results / Acceptance Criteria*
	#
	#When one of the following changed:
	#
	#* Contact lookup on SO
	#* Account lookup on SO
	#* Entity Picklist on SO
	#
	#The system should re-calculate the address fields on the Sales Order
	#
	#*PM Note:*
	#
	#* The system already provides the address on the insert of an order, {color:#FF5630}we just need to make sure to call the same logic when one of the above changes.{color}
	#* Make sure the define the criteria to only fire the trigger when related fields changes. {color:#FF5630}We dont want to introduce performance issues with unnecessary DMLs{color}
	#
	#*Business Justification:*
	#
	#Ability to change/update the entity when the Sales Order is already created.
	#
	#*CS Note:*
	#This issue is not reproducible in 20 Spring.15
	#
	#Estimate
	#
	#QA: 24h
	@REQ_PD-26895 @TEST_PD-27756 @regression @21Winter @22Winter @abinaya
	Scenario Outline: Test Entity driving the address on Sales Order
		Given User created New Sales Order with Contact as "Carole White", Account as "Global Media" & Entity as "<entityType>"
		Then User updated Sales Order record "<entity>" or "<contact>" or "<account>" value
		And User verified the Address updated in Sales Order record

		Examples:
			| entityType | entity  | contact      | account         |
			| Account    | Contact |              |                 |
			| Contact    |         | Eva Foxworth |                 |
			| Account    |         |              | Brown Household |
