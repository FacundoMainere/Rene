When(/^I go to "(.*?)"$/) do |page_name|
    visit path_to(page_name)
end

Then(/^I should see "(.*?)"$/) do |expected|
  if page.respond_to? :should
    page.should have_content(expected)
  else
    assert page.has_content?(expected)
  end
end

Given(/^I am logged in$/) do
  visit "/login"
  fill_in("name", :with => "cucumber_user")
  fill_in("email", :with => "cucumber_user@someplace.com")
  click_button "submit"
end

Given(/^I am on "(.*?)"$/) do |page_name|
    visit path_to(page_name)
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, field_content|
    fill_in(field, :with => field_content)
end

Given(/^I fill in "(.*?)" with tomorrow$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

When(/^I press "(.*?)"$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

Given(/^the appointment with "(.*?)" the day "(.*?)" at "(.*?)" with a duration of "(.*?)" minutes was already booked$/) do |arg1, arg2, arg3, arg4|
    pending # express the regexp above with the code you wish you had
end

Given(/^I fill in "(.*?)" with yesterday$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

Given(/^I fill in "(.*?)" with today$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end

Given(/^I fill in "(.*?)" with a past hour$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end
