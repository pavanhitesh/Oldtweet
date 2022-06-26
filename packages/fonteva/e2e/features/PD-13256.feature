@REQ_PD-13256
Feature: Member attempted to renew via the portal and is seeing a visualforce error message
 @REQ_PD-13256 @TEST_PD-27191 @regression @21Winter @22Winter @akash
 Scenario: Test Member attempted to renew via the portal and is seeing a visualforce error message
  Given User will select "Daniela Brown" contact
  And User opens the Rapid Order Entry page from contact
  And User should be able to add "AutoTermedPlan" item on rapid order entry
  And User navigate to "apply payment" page for "AutoTermedPlan" item from rapid order entry
  And User should be able to apply payment for "AutoTermedPlan" item using "Credit Card" payment on apply payment page
  And User should be able to remove sales order line source from the subscription
  And User navigate to community Portal page with "danielabrown@mailinator.com" user and password "705Fonteva" as "authenticated" user
  And User will select the "Subscriptions" page in LT Portal
  Then User should be able to renew the "active" subscription "AutoTermedPlan"


	
