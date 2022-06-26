@REQ_PD-27759
Feature: Form Responses for Interview Forms are missing data when the Item is purchased using Rapid Order Entry
	#*Case Reporter* Ritu Muralidhar
	#
	#*Customer* International Society for Technology in Education
	#
	#*Reproduced by* Eli Nesson in 2019.1.0.28,2019.1.0.33
	#
	#*Reference Case#* [00024888|https://fonteva.my.salesforce.com/5004V000011sDLbQAM]
	#
	#*Description:*
	#
	#When an item is purchased in ROE, and the item has an Interview Form attached, the Form Response record is missing values in the Entity, Item, and Sales Order fields.
	#
	#*Screen recording for ROE:*
	#
	#* [https://www.screencast.com/t/beneyJhs1Y2Q|https://www.screencast.com/t/beneyJhs1Y2Q]
	#
	#*Screen recording for front end checkout for comparison (correct):*
	#
	#*  [https://www.screencast.com/t/pwW4IiW9j|https://www.screencast.com/t/pwW4IiW9j]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Create a form with a field group and a few fields (no data binding)
	### [https://docs.fonteva.com/user/Creating-a-Form.1505198312.html|https://docs.fonteva.com/user/Creating-a-Form.1505198312.html|smart-link]
	## Add the above item, to the Interview form field for an item
	## Navigate to a contact
	## Click on the Rapid Order Order Entry button in the Sales Order related list
	## Add the Item above item to the order
	## Expand the item to view the form attached
	## Fill out the form
	## Complete payment
	## Navigate to the Form, view the form response record created.
	## Verify the Form Response record that was created (*it will have Contact, Account, and SOL populated but not Entity, Item, or Sales Order*)
	#
	#*Actual Results:*
	#
	#When the Form Response record is created (upon completing the form), the Entity, Item, and Sales Order fields are not populated (even though the SOL field is populated)
	#
	#When the order is paid, the Form Response's Entity, Item, and Sales Order fields are still not populated
	#
	#*Expected Results:*
	#
	#When the Form Response record is created (upon completing the form), the Entity, Item, and Sales Order fields are populated. (This is how the fields are populated when purchasing the same item on front end checkout)
	#
	#*PM Note:*
	#
	#SOL is already populated, so we can populate Sales Order and Item bc SOL has direct relationship, Account/Contact lookups, and Entity field
	#
	#*T3 Notes:*
	#Add fields itemId and soId in Form.apx and also add logic to process them.

	#Tests *Case Reporter* Ritu Muralidhar
	#
	#*Customer* International Society for Technology in Education
	#
	#*Reproduced by* Eli Nesson in 2019.1.0.28,2019.1.0.33
	#
	#*Reference Case#* [00024888|https://fonteva.my.salesforce.com/5004V000011sDLbQAM]
	#
	#*Description:*
	#
	#When an item is purchased in ROE, and the item has an Interview Form attached, the Form Response record is missing values in the Entity, Item, and Sales Order fields.
	#
	#*Screen recording for ROE:*
	#
	#* [https://www.screencast.com/t/beneyJhs1Y2Q|https://www.screencast.com/t/beneyJhs1Y2Q]
	#
	#*Screen recording for front end checkout for comparison (correct):*
	#
	#*  [https://www.screencast.com/t/pwW4IiW9j|https://www.screencast.com/t/pwW4IiW9j]
	#
	#
	#
	#*Steps to Reproduce:*
	#
	## Create a form with a field group and a few fields (no data binding)
	### [https://docs.fonteva.com/user/Creating-a-Form.1505198312.html|https://docs.fonteva.com/user/Creating-a-Form.1505198312.html|smart-link]
	## Add the above item, to the Interview form field for an item
	## Navigate to a contact
	## Click on the Rapid Order Order Entry button in the Sales Order related list
	## Add the Item above item to the order
	## Expand the item to view the form attached
	## Fill out the form
	## Complete payment
	## Navigate to the Form, view the form response record created.
	## Verify the Form Response record that was created (*it will have Contact, Account, and SOL populated but not Entity, Item, or Sales Order*)
	#
	#*Actual Results:*
	#
	#When the Form Response record is created (upon completing the form), the Entity, Item, and Sales Order fields are not populated (even though the SOL field is populated)
	#
	#When the order is paid, the Form Response's Entity, Item, and Sales Order fields are still not populated
	#
	#*Expected Results:*
	#
	#When the Form Response record is created (upon completing the form), the Entity, Item, and Sales Order fields are populated. (This is how the fields are populated when purchasing the same item on front end checkout)
	#
	#*PM Note:*
	#
	#SOL is already populated, so we can populate Sales Order and Item bc SOL has direct relationship, Account/Contact lookups, and Entity field
	#
	#*T3 Notes:*
	#Add fields itemId and soId in Form.apx and also add logic to process them.
	@TEST_PD-28356 @REQ_PD-27759 @21winter @22Winter @regression @pavan
	Scenario Outline: Test Form Responses for Interview Forms are missing data when the Item is purchased using Rapid Order Entry
		Given User will select "Coco Dulce" contact
		And User opens the Rapid Order Entry page from contact
		And User should be able to add "<item>" item on rapid order entry
		And User is able to expand the item "<item>" and fill the city name "USA" in the Form
		And User navigate to "apply payment" page for "<item>" item from rapid order entry
		When User should be able to apply payment for "<item>" item using "Credit Card" payment on apply payment page
		Then User verifies the Form Responses will have details like Contact, Account, Entity, Item, Sales Order and SalesOrderLine
		Examples:
			| item               |
			| AutoItemForm       |
			| AutoTermedFormPlan |
