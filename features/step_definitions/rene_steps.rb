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

Then(/^I should see "(.*?)" upcoming appointments$/) do |count|
  all("table#recordTable tr").count == count
end

Given(/^I am logged in$/) do
  visit "/login"
  fill_in("name", :with => "cucumber")
  fill_in("email", :with => "cucumber_user")
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

Given(/^the appointment with "(.*?)" tomorrow at "(.*?)" for "(.*?)" was already booked by "(.*?)"$/) do |medic_name, hour, patient_email, user|
  a = Appointment.add_new_appointment(medic_name, DateTime.now+1, hour[0..1].to_i, hour[3..4].to_i, patient_email, user)
  a.save
end

Given(/^the appointment with "(.*?)" yesterday at "(.*?)" for "(.*?)" was already booked by "(.*?)"$/) do |medic_name, hour, patient_email, user|
  a = Appointment.add_new_appointment(medic_name, DateTime.now-1, hour[0..1].to_i, hour[3..4].to_i, patient_email, user)
  a.save
end


Given(/^I fill in "(.*?)" with yesterday$/) do |field|
  fill_in(field, :with => (DateTime.now-1).to_s[0..9])
end

Given(/^I fill in "(.*?)" with today$/) do |field|
  fill_in(field, :with => DateTime.now.to_s[0..9])
end

Given(/^I fill in "(.*?)" with a past hour$/) do |field|
  fill_in(field, :with => (Time.now-1).to_s[11..15])
end

Given(/^I click on checkbox of "(.*?)" appointment$/) do |field|
  check(field)
end

Then(/^I should not see "(.*?)"$/) do |text|
  if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
end


After('@savesMedic') do
  Appointment.all.destroy
end
