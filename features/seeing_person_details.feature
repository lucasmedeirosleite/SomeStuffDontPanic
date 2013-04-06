Feature: Checking people information
	As an iOS user
	I want to see the information about people
	So I can learn more about people 
	
Scenario: Seeing details from the first person
	Given I am on the People screen
	When I tap person "Person 1"
	Then I should see person details for "Person 1" 
	
