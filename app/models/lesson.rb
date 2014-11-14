class Lesson < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar

	#form validation
	validates :title, :instructor, :location, presence: true
	validate :ends_at_after_starts_at
	validate :enrollment_not_negative
	validate :some_grade_level_selected

	def ends_at_after_starts_at
		if ends_at < starts_at
			errors.add(:ends_at, "can't be before Starts at")
		end
	end

	def some_grade_level_selected
		if g1_3 == false && g3_5 == false && g6_8 == false
			errors.add("Grade Level", "must be selected")
		end
	end

	def enrollment_not_negative
		if max_enrollment == nil || max_enrollment < 1
			errors.add(:max_enrollment, "must be a positive value")
		end
	end
end
