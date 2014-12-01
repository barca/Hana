class Lesson < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar

	#form validation
	validates :title, :instructor, :location, presence: true
	validate :ends_at_after_starts_at
	validate :enrollment_not_negative
	validate :some_grade_level_selected
	validate :end_date_after_start_date
  	validate :lesson_max_more_than_classroom_capacity
	validate :lesson_spans_many_days

  
    def lesson_spans_many_days
      true 
    end
        

	def lesson_max_more_than_classroom_capacity
	  classroom = Classroom.find_by(name: location)
	  if classroom == nil || max_enrollment == nil
	  elsif max_enrollment > classroom.max_occupancy
	    errors.add(:max_enrollment, "for this classroom cannot exceed #{classroom.max_occupancy}")
	  end
	end

	def ends_at_after_starts_at
		if ends_at.to_i < starts_at.to_i
			errors.add(:ends_at, "can't be before Starts at")
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

	def end_date_after_start_date
		if mon || tue || wed || thu || fri
			true
		end
	end
end
