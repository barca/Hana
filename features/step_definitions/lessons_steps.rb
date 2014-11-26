# Add a declarative step here for populating the DB with lessons.

Given /the following lessons exist/ do |lessons_table|
  lessons_table.hashes.each do |lesson|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Lesson.create!(lesson)
  end
end

And /the following classrooms exist/ do |classrooms_table|
  classrooms_table.hashes.each do |classroom|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Classroom.create!(classroom)
  end
end
Then (/^on "(.*?)" I should see "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /the instructor of "(.*)" should be "(.*)"$/ do |arg1,arg2|
	page.body.match /.*{arg1}.*{arg2}/
end


