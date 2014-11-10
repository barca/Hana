class Lesson < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar

	#form validation
	validates :title, :instructor, :grade_level, :location, presence: true
	validate :ends_at_after_starts_at
	validate :enrollment_not_negative

	def ends_at_after_starts_at
		if ends_at < starts_at
			errors.add(:ends_at, "can't be before Starts at")
		end
	end

	def enrollment_not_negative
		if max_enrollment == nil || max_enrollment < 1
			errors.add(:max_enrollment, "must be a positive value")
		end
	end
end
