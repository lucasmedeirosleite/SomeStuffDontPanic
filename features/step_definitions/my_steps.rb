Given(/^I am on the People screen$/) do
  wait_for(:timeout => 5) { element_exists("label text:'Person 1' parent tableViewCell") }
end
 
When(/^I tap person "(.*?)"$/) do |person_name|
  touch "tableView tableViewCell index:0"
end

Then(/^I should see person details for "(.*?)"$/) do |person_name|
  wait_for(:timeout => 1) { element_exists("textField text:'Person 1'") }
end