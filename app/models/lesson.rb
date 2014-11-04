class Lesson < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar

	#form validation
	validates :title, :instructor, :grade_level, :location, presence: true
	validates :max_enrollment, numericality: { only_integer: true }
	validate :ends_at_after_starts_at

	def ends_at_after_starts_at
		if ends_at < starts_at
			errors.add(:ends_at, "can't be before Starts at")
		end
	end
end
