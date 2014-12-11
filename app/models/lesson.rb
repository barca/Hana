class Lesson < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar

	#form validation
  validates :ends_at, :starts_at, :title, :instructor, :location, presence: true
	validate :some_grade_level_selected
	validate :ends_at_after_starts_at
	validate :enrollment_not_negative
  	validate :lesson_max_more_than_classroom_capacity
  	validate :end_date_after_start_date



	def lesson_max_more_than_classroom_capacity
	  classroom = Classroom.find_by(name: location)
	  if classroom == nil || max_enrollment == nil
	  elsif max_enrollment > classroom.max_occupancy
	    errors.add(:max_enrollment, "for this classroom cannot exceed #{classroom.max_occupancy}")
	  end
	end

  def starts_date_not_nil
    if start_date == nil
      errors.add(:start_date, "can't be empty")
    end
  end
	def end_date_after_start_date
		if mon==true || tue==true || wed==true || thu==true || fri==true
			if end_date < start_date
				errors.add(:until, "can't be before start date for repeating lessons")
			end
		end
	end


	def ends_at_after_starts_at
		if ends_at.to_i < starts_at.to_i
			errors.add(:ends_at, "can't be before starts time")
		end
	end

	def some_grade_level_selected
		if g1_3 == false && g3_5 == false && g6_8 == false
			errors.add(:grade_levels, "must be selected")
		end
	end

	def enrollment_not_negative
		if max_enrollment == nil || max_enrollment < 1
			errors.add(:max_enrollment, "must be a positive value")
		end
	end

end
