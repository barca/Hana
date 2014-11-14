module LessonsHelper
	def lessonsOn(date, lessons)
		return lessons.where(starts_at: date.beginning_of_day..date.end_of_day)
	end
end
