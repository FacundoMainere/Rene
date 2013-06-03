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

Given(/^I fill in "(.*?)" with tomorrow$/) do |field|
  fill_in(field, :with => (DateTime.now+1).to_s[0..9])
end

When(/^I press "(.*?)"$/) do |button|
  click_button button
end

Given(/^the appointment with "(.*?)" tomorrow at "(.*?)" with a duration of "(.*?)" minutes was already booked$/) do |medic_name, hour, duration|
  a = Appointment.add_new_appointment(medic_name, DateTime.now+1, hour[0..1].to_i, hour[3..4].to_i, duration)
  puts a.save
end

Given(/^I fill in "(.*?)" with yesterday$/) do |field|
  fill_in(field, :with => (DateTime.now-1).to_s[0..9])
end

Given(/^I fill in "(.*?)" with today$/) do |field|
  fill_in(field, :with => DateTime.now.to_s[0..9])
end

Given(/^I fill in "(.*?)" with a past hour$/) do |field|
  fill_in(field, :with => (Time.now-3600).to_s[11..15])
end

After('@savesMedic') do
  Appointment.first(:medic =>'Alvaro Ropereo').destroy
end
