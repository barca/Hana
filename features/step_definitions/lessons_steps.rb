# Add a declarative step here for populating the DB with lessons.
When (/^I set lesson start at to "(.*?)" "(.*?)"$/) do | date, time|
  time_chunks = date.split("-");
  x = 1
  time_chunks.each do |fill|
    select fill,:from => "lesson_start_date_#{x}i"
    x += 1
  end
  time_chunks = time.split(":")
  time_chunks.each do |fill|
    select fill,:from => "lesson_starts_at_#{x}i"
    x += 1
  end
end
When (/^I set lesson end time to "(.*?)"$/) do |time|
  time_chunks = time.split(":")
  x = 4
  time_chunks.each do |fill|
    select fill, :from => "lesson_ends_at_#{x}i"
    x += 1
  end
end
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


