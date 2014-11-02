class Lesson < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar
end
