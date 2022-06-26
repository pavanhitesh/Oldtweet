@REQ_PD-22764
Feature: When critical update Enable known addresses portal checkout is activated, we get an 'Under construction' error after clicking 'Invoice Me' option from cpbase checkout page
	#*Reproduced by* Effie Zhang in 2019.1.0.17
	#
	#*Reference Case#*[00020967|https://fonteva.my.salesforce.com/5003A00000zWCk5QAG]
	#
	#*Description:*
	#
	#The org only has 1 active community (with suffix), which is lightning community. And there is a join process built on this lightning community.
	#
	#When critical update Enable known addresses portal checkout is activated, if we use Invoice Me to check out in cpbase via Join Process, it gives 'Under construction' error because there is no active community without suffix. Attaching error screenshot.
	#
	#Note - under the same scenario, if {color:#3e3e3c}Enable known addresses portal checkout is deactivated, the receipt was able to render correctly without any error after checking out with Invoice Me in Join Process cpbase checkout.{color}
	#
	#{color:#3e3e3c}Workaround for now: disable critical update KA to render the receipt correctly{color}
	#
	#
	#
	#* Create a join process, include a product and a payment step in the JP
	#** Here are the steps to create a join process [https://docs.fonteva.com/user/Join-Process---Getting-Started.1502248965.html|https://docs.fonteva.com/user/Join-Process---Getting-Started.1502248965.html|smart-link] 
	#* Go to frontend of the Join Process, go through the process, and land on cpabse checkout page
	#* Join process example in my QA org -
	#[https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/joinapi__membershiplist?id=a204T000000gHpKQAU&order=1|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/joinapi__membershiplist?id=a204T000000gHpKQAU&order=1]
	#
	#
	#
	#*PM Note:*
	#
	#The issue is reported against JP and CPBASE Checkout, we will validate wit LT Checkout
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Make sure the org only has an active LT community, it needs to be a lighting community and it needs a suffix in the community URL. For example
	#
	#!https://fonteva.aha.io/attachments/6818184011313927581/token/e26a42d36ab1d225be5f74967e2b8480f10fce4c554af82a6b128c822748db00.download?size=original|width=2158,height=183!
	#
	#* Navigate to Spark *Admin >  Apps > Charge* Under Critical Updates section make sure the critical update “{color:#3e3e3c}*Enable known addresses portal checkout*{color}{color:#3e3e3c}” is activated{color}
	#* Navigate to the store record, 
	#** Select the *Invoice Me payment type* and make sure *Is Enabled = TRUE* and Display on *Frontend Checkout = TRUE*
	#* Navigate to the portal store 
	#* Select an item and add it to the cart 
	#* Continue to the checkout page 
	#* Choose the Invoice Me option, fill in the reference number, and complete the transaction
	#* See error - it will try to render the receipt with the community without the suffix - because that community is not active,{color:#3e3e3c}' Under construction' error displayed{color}
	#
	#
	#
	#*Actual Results:*
	#
	#'Under construction' error. See screenshot
	#
	#!https://fonteva.aha.io/attachments/6818184011154779247/token/d96afb286dd6ea54cedd095472a7353013ddee08501819a6b93a3af2911ff87e.download?size=original|width=1762,height=183!
	#
	#*Expected Results:*
	#
	#Receipt render correctly, just like when {color:#3e3e3c}Enable known addresses portal checkout is deactivated{color}

	#Tests *Reproduced by* Effie Zhang in 2019.1.0.17
	#
	#*Reference Case#*[00020967|https://fonteva.my.salesforce.com/5003A00000zWCk5QAG]
	#
	#*Description:*
	#
	#The org only has 1 active community (with suffix), which is lightning community. And there is a join process built on this lightning community.
	#
	#When critical update Enable known addresses portal checkout is activated, if we use Invoice Me to check out in cpbase via Join Process, it gives 'Under construction' error because there is no active community without suffix. Attaching error screenshot.
	#
	#Note - under the same scenario, if {color:#3e3e3c}Enable known addresses portal checkout is deactivated, the receipt was able to render correctly without any error after checking out with Invoice Me in Join Process cpbase checkout.{color}
	#
	#{color:#3e3e3c}Workaround for now: disable critical update KA to render the receipt correctly{color}
	#
	#
	#
	#* Create a join process, include a product and a payment step in the JP
	#** Here are the steps to create a join process [https://docs.fonteva.com/user/Join-Process---Getting-Started.1502248965.html|https://docs.fonteva.com/user/Join-Process---Getting-Started.1502248965.html|smart-link] 
	#* Go to frontend of the Join Process, go through the process, and land on cpabse checkout page
	#* Join process example in my QA org -
	#[https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/joinapi__membershiplist?id=a204T000000gHpKQAU&order=1|https://us-tdm-tso-15eb63ff4c6-1626e-16cf8baf3db.force.com/LightningMemberPortal/joinapi__membershiplist?id=a204T000000gHpKQAU&order=1]
	#
	#
	#
	#*PM Note:*
	#
	#The issue is reported against JP and CPBASE Checkout, we will validate wit LT Checkout
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Make sure the org only has an active LT community, it needs to be a lighting community and it needs a suffix in the community URL. For example
	#
	#!https://fonteva.aha.io/attachments/6818184011313927581/token/e26a42d36ab1d225be5f74967e2b8480f10fce4c554af82a6b128c822748db00.download?size=original|width=2158,height=183!
	#
	#* Navigate to Spark *Admin >  Apps > Charge* Under Critical Updates section make sure the critical update “{color:#3e3e3c}*Enable known addresses portal checkout*{color}{color:#3e3e3c}” is activated{color}
	#* Navigate to the store record, 
	#** Select the *Invoice Me payment type* and make sure *Is Enabled = TRUE* and Display on *Frontend Checkout = TRUE*
	#* Navigate to the portal store 
	#* Select an item and add it to the cart 
	#* Continue to the checkout page 
	#* Choose the Invoice Me option, fill in the reference number, and complete the transaction
	#* See error - it will try to render the receipt with the community without the suffix - because that community is not active,{color:#3e3e3c}' Under construction' error displayed{color}
	#
	#
	#
	#*Actual Results:*
	#
	#'Under construction' error. See screenshot
	#
	#!https://fonteva.aha.io/attachments/6818184011154779247/token/d96afb286dd6ea54cedd095472a7353013ddee08501819a6b93a3af2911ff87e.download?size=original|width=1762,height=183!
	#
	#*Expected Results:*
	#
	#Receipt render correctly, just like when {color:#3e3e3c}Enable known addresses portal checkout is deactivated{color}
	@TEST_PD-28830 @REQ_PD-22764 @21Winter @22Winter @regression @pavan
	Scenario: Test When critical update Enable known addresses portal checkout is activated, we get an 'Under construction' error after clicking 'Invoice Me' option from cpbase checkout page
		Given User navigate to community Portal page with "cdulce@mailinator.com" user and password "705Fonteva" as "authenticated" user
		And User should be able to select "AutoItem2" item with quantity "1" on store
		And User should click on the checkout button
		When User successfully pays for the order using Invoice Me
		Then User should see the "Invoice" created confirmation message
