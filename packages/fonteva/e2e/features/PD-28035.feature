@REQ_PD-28035
Feature: Hidden Show more button on Chatter Posts
	#*Case Reporter* Lakshmi Prasanna Danduboina
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 21Winter.0.0
	#
	#*Reference Case#* [00029292|https://fonteva.my.salesforce.com/5004V000014jNFDQA2]
	#
	#*Description:*
	#
	#We are currently experiencing a bug whereby chatter posts over a certain character limit are not displaying the “Expand post" link that typically expends the post to reveal the remaining characters.
	#
	#As you can see above the post visibly cuts off. Where there should be a Show more link the page is white. That said if the user hovers the cursor over that blank area you are able to expand the chatter post to reveal the remaining text.
	#
	#After inspecting the page we were able to find the following:
	#
	#As you can see the page is applying a fadeout to the space in question. When we manually remove the FadeOut the Show More link appears. This change cannot be manipulated via the css editing provided in the community . (see screenshot)
	#
	#*Steps to Reproduce:*
	#
	#Login to the GCO 00D5Y000001NF95
	#
	#Find Bob kelley contact https://gcon4qrsd.my.salesforce.com/0035Y00003nW4a6
	#
	#Login in to the community
	#
	#Find and click on Groups
	#
	#Under Groups, Find Fon-Annual Conference
	#
	#Scroll down to see the chatter post "Excited and honored to be this year's Keynote Speaker at the Annual Conference!"
	#
	#Find the long comment under the "Excited and honored to be this year's Keynote Speaker at the Annual Conference!" post.
	#
	#(see screenshots).
	#
	#Upon inspecting the element, find the fadeout class and uncheck the checkboxes and you ll be able to see the Expand post.
	#
	#*Actual Results:*
	#
	#"Expand post" link is not available.
	#
	#*Expected Results:*
	#
	#"Expand post" list should be available for the user to see the full comment.
	#
	#*Business Justification:*
	#
	#community group members are not able to see complete comment on the chatter post if the chatter post comment is long.
	#
	#When the chatter post is long, user should see "Expand post" link and upon clicking the "Expand post", user should be able to see the entire post.
	#
	#However, User is not able to see the "Expand post" link on the community group comment.
	#
	#*T3 Notes:*
	#
	#Works well in a non-fonteva template, see screenshot for comparison
	#
	#The issue seems to come from iziToast. Once we manually remove {{animation}}{{: m .7s ease both;}} "Expand Post" shows correctly

	#Tests *Case Reporter* Lakshmi Prasanna Danduboina
	#
	#*Customer* ZERO TO THREE: National Center for Infants, Toddlers and Families
	#
	#*Reproduced by* Prathyusha Pamudoorthi in 21Winter.0.0
	#
	#*Reference Case#* [00029292|https://fonteva.my.salesforce.com/5004V000014jNFDQA2]
	#
	#*Description:*
	#
	#We are currently experiencing a bug whereby chatter posts over a certain character limit are not displaying the “Expand post" link that typically expends the post to reveal the remaining characters.
	#
	#As you can see above the post visibly cuts off. Where there should be a Show more link the page is white. That said if the user hovers the cursor over that blank area you are able to expand the chatter post to reveal the remaining text.
	#
	#After inspecting the page we were able to find the following:
	#
	#As you can see the page is applying a fadeout to the space in question. When we manually remove the FadeOut the Show More link appears. This change cannot be manipulated via the css editing provided in the community . (see screenshot)
	#
	#*Steps to Reproduce:*
	#
	#Login to the GCO 00D5Y000001NF95
	#
	#Find Bob kelley contact https://gcon4qrsd.my.salesforce.com/0035Y00003nW4a6
	#
	#Login in to the community
	#
	#Find and click on Groups
	#
	#Under Groups, Find Fon-Annual Conference
	#
	#Scroll down to see the chatter post "Excited and honored to be this year's Keynote Speaker at the Annual Conference!"
	#
	#Find the long comment under the "Excited and honored to be this year's Keynote Speaker at the Annual Conference!" post.
	#
	#(see screenshots).
	#
	#Upon inspecting the element, find the fadeout class and uncheck the checkboxes and you ll be able to see the Expand post.
	#
	#*Actual Results:*
	#
	#"Expand post" link is not available.
	#
	#*Expected Results:*
	#
	#"Expand post" list should be available for the user to see the full comment.
	#
	#*Business Justification:*
	#
	#community group members are not able to see complete comment on the chatter post if the chatter post comment is long.
	#
	#When the chatter post is long, user should see "Expand post" link and upon clicking the "Expand post", user should be able to see the entire post.
	#
	#However, User is not able to see the "Expand post" link on the community group comment.
	#
	#*T3 Notes:*
	#
	#Works well in a non-fonteva template, see screenshot for comparison
	#
	#The issue seems to come from iziToast. Once we manually remove {{animation}}{{: m .7s ease both;}} "Expand Post" shows correctly
	@REQ_PD-28035 @TEST_PD-28914 @regression @21Winter @22Winter @abinaya
	Scenario: Test Hidden Show more button on Chatter Posts
		Given User navigate to community Portal page with "ninadoe@mailinator.com" user and password "705Fonteva" as "authenticated" user
		Then User opens "Fon-Annual Conference" group and verifies Expand Post links on Chatter Posts
