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
