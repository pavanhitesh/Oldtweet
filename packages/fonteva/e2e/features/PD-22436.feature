@REQ_PD-22436
Feature: Internal Staff user can assign more active subscribers than my assignment max
	#*Reproduced by* Erich Ehinger in 19.1.0.14
	#
	#*Reference Case#*[00020965|https://fonteva.my.salesforce.com/5003A00000zWC0mQAG]
	#
	#*Description:*
	#
	#As a staff in the back-end, I can assign more active subscribers than my assignment max.
	#
	#{color:#00b8d9}*According to OrderApi.Assignments.cls starting at line 249, it should evaluate the # of assignments from the SOL and throw an error when there are no more allowed, but it is not doing that.*{color}
	#
	#
	#
	#*PM NOTE:*
	#
	#* Assignment object has a lookup to
	#** SOL
	#** TERM (labeled as subscriber u can see it as a related list)
	#** SUBSCRIPTION (labeled as subscriber u can see it as a related list)
	#* I think the problem with this code is, it is checking the SOL lookup on the Assignment Object to validate the max number of assignments.
	#* [https://github.com/Fonteva/orderapi/blob/9818123f19209c77182585d0e35ef35e0f2a1a34/src/classes/Assignments.cls#L267|https://github.com/Fonteva/orderapi/blob/9818123f19209c77182585d0e35ef35e0f2a1a34/src/classes/Assignments.cls#L267]
	#* If a user adds assignments to the *TERM* (OrderApi__Renewal__c) under the *Membership* (Subscription__c) record directly they might not be adding SOL lookup. We should do a similar logic for TERM Lookup. Users should not be assigning more than allowed assignments.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Purchase a membership where
	#** Item.Enable Assignments = TRUE
	#** Item.Maximum Number of Assignments = 2
	#* Go to membership record and add 2 new subscriber records with Term, assignment role and SOL populated.
	#
	#
	#
	#*Actual Results:*
	#
	#The system allows you to add the 3rd subscriber record
	#
	#The SOL record says -1 Assignments Available
	#
	#The membership record says term active assignments = 2 when in reality it's 3
	#
	#
	#
	#*Expected Results:*
	#
	#The system should not allow you to add the 3rd subscriber record

	#Tests *Reproduced by* Erich Ehinger in 19.1.0.14
	#
	#*Reference Case#*[00020965|https://fonteva.my.salesforce.com/5003A00000zWC0mQAG]
	#
	#*Description:*
	#
	#As a staff in the back-end, I can assign more active subscribers than my assignment max.
	#
	#{color:#00b8d9}*According to OrderApi.Assignments.cls starting at line 249, it should evaluate the # of assignments from the SOL and throw an error when there are no more allowed, but it is not doing that.*{color}
	#
	#
	#
	#*PM NOTE:*
	#
	#* Assignment object has a lookup to
	#** SOL
	#** TERM (labeled as subscriber u can see it as a related list)
	#** SUBSCRIPTION (labeled as subscriber u can see it as a related list)
	#* I think the problem with this code is, it is checking the SOL lookup on the Assignment Object to validate the max number of assignments.
	#* [https://github.com/Fonteva/orderapi/blob/9818123f19209c77182585d0e35ef35e0f2a1a34/src/classes/Assignments.cls#L267|https://github.com/Fonteva/orderapi/blob/9818123f19209c77182585d0e35ef35e0f2a1a34/src/classes/Assignments.cls#L267]
	#* If a user adds assignments to the *TERM* (OrderApi__Renewal__c) under the *Membership* (Subscription__c) record directly they might not be adding SOL lookup. We should do a similar logic for TERM Lookup. Users should not be assigning more than allowed assignments.
	#
	#
	#
	#*Steps to Reproduce:*
	#
	#* Purchase a membership where
	#** Item.Enable Assignments = TRUE
	#** Item.Maximum Number of Assignments = 2
	#* Go to membership record and add 2 new subscriber records with Term, assignment role and SOL populated.
	#
	#
	#
	#*Actual Results:*
	#
	#The system allows you to add the 3rd subscriber record
	#
	#The SOL record says -1 Assignments Available
	#
	#The membership record says term active assignments = 2 when in reality it's 3
	#
	#
	#
	#*Expected Results:*
	#
	#The system should not allow you to add the 3rd subscriber record
	@TEST_PD-28764 @REQ_PD-22436 @regression @21Winter @22Winter @ngunda
	Scenario: Test Internal Staff user can assign more active subscribers than my assignment max
		Given User creates salesOrders with information provided below:
			| Contact      | Account          | BusinessGroup | Entity  | PostingEntity | ScheduleType   | ItemName                 | Qty |
			| Mannik Gunda | Gundas HouseHold | Foundation    | Contact | Invoice       | Simple Invoice | AutoAssignmentMembership | 1   |
		And User marks the created orders as ready for payment
		And User "Mannik Gunda" makes payment for the Orders created
		Then User tries to add more subscribers than max allowed to the term and validates the error
			| Name         |
			| Max Foxworth |
			| Eva Foxworth |
