@REQ_PD-29765
Feature: Map a form to a decimal field on the Contact object using Form Builder
	#C89857
	#
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	#1. 1. Locate any Contact from the Contacts tab in the eBusiness app
	#1. Click the Force.com pop-out arrow located on the right side of the page
	#1. Next to View Fields, hover to the right side and click + New
	#1. Select Number > Click Next
	#1. Enter field label > Click Next > Click Next > Click Save
	#Expected Result:
	#Custom decimal field should be created
	#2. 1. Click the Form Builder app > Forms tab >Click New
	#1. Enter Form Name
	#1. Click Save
	#1. Click the Form Builder button at the top of the page
	#1. Click New Field Group
	#1. Enter Field Group Name
	#1. Enter user Instructions
	#1. Set Mapped Object Field = Contact
	#1. Set Database Operation = Insert
	#1. Click Save
	#1. Click New Field
	#1. Set Type = Decimal
	#1. Enter Field Label
	#1. Under Database Options, set Mapped Object Field = (Field created in Step 1)
	#
	#Expected Result:
	#User should successfully be able to map the custom decimal field created on the Contact record to the New Field on the formEXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):

	#C89857
	#
	#PRE-CONDITIONS:
	#
	#STEPS:
	#
	#1. 1. Locate any Contact from the Contacts tab in the eBusiness app1. Click the Force.com pop-out arrow located on the right side of the page1. Next to View Fields, hover to the right side and click + New1. Select Number > Click Next1. Enter field label > Click Next > Click Next > Click SaveExpected Result:Custom decimal field should be created2. 1. Click the Form Builder app > Forms tab >Click New1. Enter Form Name1. Click Save1. Click the Form Builder button at the top of the page1. Click New Field Group1. Enter Field Group Name1. Enter user Instructions1. Set Mapped Object Field = Contact1. Set Database Operation = Insert1. Click Save1. Click New Field1. Set Type = Decimal1. Enter Field Label1. Under Database Options, set Mapped Object Field = (Field created in Step 1)
	#
	#Expected Result:User should successfully be able to map the custom decimal field created on the Contact record to the New Field on the formEXPECTED RESULTS:
	#
	#ALTERNATE FLOW(S):
 @TEST_PD-29764 @REQ_PD-29765 @regression @21Winter @22Winter @Jhansi
	Scenario: Map a form to a decimal field on the Contact object using Form Builder
		Given User navigate to community Portal page with "julianajacobson@mailinator.com" user and password "705Fonteva" as "authenticated" user
		When User opens "AutoDecimalForm" form page
		Then User Submit the form for decimal "Credit Score" field mapped to contact "Juliana Jacobson" and verify response
