require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |field, value|
  select field, :from => value, visible: false
end

Then (/^I should see "(.*?)"$/) do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

When /^(?:|I )press "(.*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )click "(.*)"$/ do |link|
   click_link(link)
end

When /^(?:|I )check "(.*)"$/ do |button|
  check(button)
end

Then /^I should locate "(.*?)" in "(.*?)"$/ do |lesson, calendar|
  within('div#' + calendar + ".weekCalendar") do 
    page.should have_content(lesson)
  end
end 

Then /^I should not locate "(.*?)" in "(.*?)"$/ do |lesson,calendar|
  within('div#' + calendar + ".weekCalendar") do 
    page.should !(have_content(lesson))
  end
end 



Then(/^I should witness today$/) do
   page.has_content?('#{Date.today.day}')
end

Then(/^I should not witness seven days from today$/) do
   page.should have_no_content('#{Date.today.day} + 7')
end


Then(/^I should not see "(.*?)"$/) do |arg1|
  page.should !(have_content(arg1))
end

Then(/^the color of "(.*?)" in "(.*?)" should be "(.*?)"$/) do |lesson, calendar, color|
  within('div#' + calendar + ".weekCalendar") do 
    page.should (have_content(lesson))
    page.should have_css("div.lessonBlock")
  end
end

Then(/^I should see a reordering of "(.*?)" before "(.*?)"$/) do |class1, class2| 
  RSpec::Matchers.define :appear_before do |class2|
  match do |class1|
    page.body.index(class1) < page.body.index(class2)
  end
  end
end 

When(/^I click the first "(.*?)"$/) do |word|
  page.first(:link, "#{word}").click  
end

When(/^I click the OK$/) do
  page.driver.browser.switch_to.alert.accept
end 

When(/^I click the first classroom "(.*?)"$/) do |arg1|
 within('div#classrooms.weekCalendarClassrooms') do 
      page.first(:link, arg1).click  
  end
end


