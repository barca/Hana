module LessonsHelper

	#find lessons occuring on a given day
	def lessonsOn(date, lessons, grade_level)
		dayTomorrow = (date + 1)
		dayYesterday = (date - 1)
    classes = lessons.where("\"lessons\".\"start_date\" < ?", dayTomorrow)
    classes = classes.where("\"lessons\".\"end_date\" > ?" , dayYesterday)

		days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
		dayOfWeek = days_of_week[(date.wday)]
		if dayOfWeek == "sun" || dayOfWeek == "sat"
			#classes don't reccur on weekends
			return classes.where(start_date: date.beginning_of_day..date.end_of_day).order(:starts_at)
		else
			dayStart = "#{date.strftime("%Y-%m-%d")} 05:00:00.000000"
			dayTomorrow = date + 1
			dayEnd = "#{dayTomorrow.strftime("%Y-%m-%d")} 04:59:59.999999"
			#SQL to return lessons for the appropriate grade level that occur on a given day
      classes = lessons.where("\"lessons\".\"start_date\" < ? or \"lessons\".\"start_date\" = ?", dayTomorrow, date)
      classes = classes.where("\"lessons\".\"end_date\" > ?" , dayYesterday)
			classes = classes.where("\"lessons\".\"#{dayOfWeek}\" = \'t\'")
		  return classes.where("\"lessons\".\"#{grade_level}\" = \'t\'").order(:starts_at)
  end
	end
    def dailyAvailableClassrooms(date)

      days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
      dayOfWeek = days_of_week[(date.wday)]
      availables = []
      if dayOfWeek != "sun" && dayOfWeek != "sat"
	      allRooms = Classroom.all.order(:name)
	      allRooms.each do |classroom|
	        if classNotOccupiedOnDay(classroom, date)
	          availables << classroom
	        end
	      end
	  end
	  return availables
    end

    def classNotOccupiedOnDay(classroom, date)
      days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
      dayOfWeek = days_of_week[(date.wday)]
      #currently only returns classes available on a specific day
			classrooms = Lesson.where("\"lessons\".\"start_date\" = ? or \"lessons\".\"start_date\" < ?", date, date + 1)
      classrooms = classrooms.where("\"lessons\".\"#{dayOfWeek}\" = \'t\'")
      classrooms = classrooms.where("\"lessons\".\"end_date\" > \'#{date-1}\'")
      @lessons = classrooms.where("\"lessons\".\"location\" = ?", classroom.name)
      if @lessons == []
        return true
      else
        return false
      end
    end

	def getLessonColor(lesson)
		lessons_classroom = Classroom.where(name: lesson.location)
		if lessons_classroom.empty?
			"black"
		else
			lessons_classroom[0].color
		end
	end

end
