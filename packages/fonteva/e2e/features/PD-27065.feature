@REQ_PD-27065
Feature: In a Lightning Community, the Order Summary Link on an Order is generating a duplicate parameter in the URL
	#*Case Reporter* Johnathan Thacker
	#
	#*Customer* Motor & Equipment Manufacturers Association
	#
	#*Reproduced by* John Herrera in 20Spring.0.15
	#
	#*Reference Case#* [00028154|https://fonteva.my.salesforce.com/5004V000013aUDVQA2]
	#
	#*Description:*
	#
	#* When copying the link to the clipboard, the link is generating with an extra parameter
	#* When the duplicate parameter is removed (ie "/LightningCommunity"), the End User can advance to pay the invoice
	#* No System Logs or Debug Logs are generated
	#
	#Screen recording of issue:
	#
	#https://www.screencast.com/t/s7hRnj06dRSh
	#
	#GCO Org ID:
	#
	#00D4x000000JXuG
	#
	#*Example link that is generated from Order in the recording above:*
	#
	#https://us-tdm-tso-15eb63ff4c6-1626e-175b0628382.force.com*/LightningMemberPortal*/s/LightningMemberPortal/order-view?ids=tbZo1zpwuNbIy4VjvfFXRLE3IDAXSwhPS2lJD1huCeM=&entityId=0034x000002JmQYAA0
	#
	#*Steps to Reproduce:*
	#
	#1) Login to the Lightning Community as a user (eg Aaron Marsh)
	#
	#2) Navigate to Orders
	#
	#3) Click into an Order/Invoice
	#
	#4) Select the Order Summary Link icon at the top right
	#
	#5) Paste the copied link in an incognito window to see the invalid page error
	#
	#*Actual Results:*
	#
	#The Order Summary Link is generating a URL with a duplicate parameter for the community name.
	#
	#*Expected Results:*
	#
	#The Order Summary Link generates a URL that does not include a duplicate parameter for the community name.
	#
	#*Business Justification:*
	#
	#* Customers depend on this to pay invoices as a Guest User
	#
	#*T3 Notes:*
	#
	#02/25 -: Issue seems in "handleCopyLinkClicked" Method of OrdersOverview.js(LTE) lwc component,this method is executed through Method "handleOrdersOverviewCopyLinkClicked" of statementbuilder.js (LTE) when click on 'copy to clipboard' option.
	#
	#[https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/lwc/ordersOverview/ordersOverview.js#L1|https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/lwc/ordersOverview/ordersOverview.js#L145]+{color:#1155CC}45{color}+

	#Tests *Case Reporter* Johnathan Thacker
	#
	#*Customer* Motor & Equipment Manufacturers Association
	#
	#*Reproduced by* John Herrera in 20Spring.0.15
	#
	#*Reference Case#* [00028154|https://fonteva.my.salesforce.com/5004V000013aUDVQA2]
	#
	#*Description:*
	#
	#* When copying the link to the clipboard, the link is generating with an extra parameter
	#* When the duplicate parameter is removed (ie "/LightningCommunity"), the End User can advance to pay the invoice
	#* No System Logs or Debug Logs are generated
	#
	#Screen recording of issue:
	#
	#https://www.screencast.com/t/s7hRnj06dRSh
	#
	#GCO Org ID:
	#
	#00D4x000000JXuG
	#
	#*Example link that is generated from Order in the recording above:*
	#
	#https://us-tdm-tso-15eb63ff4c6-1626e-175b0628382.force.com*/LightningMemberPortal*/s/LightningMemberPortal/order-view?ids=tbZo1zpwuNbIy4VjvfFXRLE3IDAXSwhPS2lJD1huCeM=&entityId=0034x000002JmQYAA0
	#
	#*Steps to Reproduce:*
	#
	#1) Login to the Lightning Community as a user (eg Aaron Marsh)
	#
	#2) Navigate to Orders
	#
	#3) Click into an Order/Invoice
	#
	#4) Select the Order Summary Link icon at the top right
	#
	#5) Paste the copied link in an incognito window to see the invalid page error
	#
	#*Actual Results:*
	#
	#The Order Summary Link is generating a URL with a duplicate parameter for the community name.
	#
	#*Expected Results:*
	#
	#The Order Summary Link generates a URL that does not include a duplicate parameter for the community name.
	#
	#*Business Justification:*
	#
	#* Customers depend on this to pay invoices as a Guest User
	#
	#*T3 Notes:*
	#
	#02/25 -: Issue seems in "handleCopyLinkClicked" Method of OrdersOverview.js(LTE) lwc component,this method is executed through Method "handleOrdersOverviewCopyLinkClicked" of statementbuilder.js (LTE) when click on 'copy to clipboard' option.
	#
	#[https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/lwc/ordersOverview/ordersOverview.js#L1|https://github.com/Fonteva/LightningLens/blob/20Spring/community/main/default/lwc/ordersOverview/ordersOverview.js#L145]+{color:#1155CC}45{color}+
	@REQ_PD-27065 @TEST_PD-27707 @regression @21Winter @22Winter
	Scenario: Test In a Lightning Community, the Order Summary Link on an Order is generating a duplicate parameter in the URL
		Given All salesOrders from contact "Daniela Brown" are deleted
		When User will select "Daniela Brown" contact
		Then User opens the Rapid Order Entry page from contact
		Then User should be able to add "AutoItem1" item on rapid order entry
		Then User selects "Invoice" as payment method and proceeds further
		Then User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User will select the "Orders" page in LT Portal
		And User should be able to copy and verify the order summary link
