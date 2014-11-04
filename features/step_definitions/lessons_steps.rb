# Add a declarative step here for populating the DB with lessons.

Given /the following lessons exist/ do |lessons_table|
  lessons_table.hashes.each do |lesson|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Lesson.create!(lesson)
  end
end

Then /the instructor of "(.*)" should be "(.*)"$/ do |arg1,arg2|
	page.body.match /.*{arg1}.*{arg2}/
end 


