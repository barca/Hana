module LessonsHelper
	def lessonsOn(date, classes, grade_level)
		dayTomorrow = (date + 1)
		dayYesterday = (date - 1)
    	classes = classes.where("\"lessons\".\"starts_at\" < ?", date + 1)
    	classes = classes.where("\"lessons\".\"end_date\" > ?" , date - 1)

		days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
		dayOfWeek = days_of_week[(date.wday)]
		if dayOfWeek == "sun" || dayOfWeek == "sat"
			return classes.where(starts_at: date.beginning_of_day..date.end_of_day)
		else
			dayStart = "#{date.strftime("%Y-%m-%d")} 05:00:00.000000"
			dayTomorrow = date + 1
			dayEnd = "#{dayTomorrow.strftime("%Y-%m-%d")} 04:59:59.999999"

			return Lesson.find_by_sql("SELECT \"lessons\".* FROM \"lessons\"  WHERE (\"lessons\".\"#{grade_level}\" = \'t\' AND (\"lessons\".\"starts_at\" < \'#{dayTomorrow}\') AND (\"lessons\".\"end_date\" > \'#{dayYesterday}\')) AND ((\"lessons\".\"starts_at\" BETWEEN \'#{dayStart}\' AND \'#{dayEnd}\') OR \"lessons\".\"#{dayOfWeek}\" = \'t\')")
		end
	end

	def repeat_until(end_date, start_date, day)

		date = start_date
		days_of_week = ['mon', 'tue', 'wed', 'thu', 'fri']
		weekDay = "#{day}?"
		while date <= end_date.end_of_day
			if date.send(weekDay.to_sym)
				date = date + 7
			else
				date = date + 1
			end
		end
	end








	def repeat(days, number = 0, start_date, end_date)
	    days_of_week = ['m','t','w','th','f','s','sun']
	    #only showing those selected (ie. ['m'] means repeat once a week on monday)
	    #number = number of repeats, and start_date is the date-time of the first event in series
	    curr_day = start_date
	    while number > 0
	      start_date = (start_date.to_time + 1.days).to_datetime
	      end_date = (end_date.to_time + 1.days).to_datetime
	      if days.includes? start_date.day
	        lesson.create_with(start_date, end_date)
	        number -= 1
	      end
	    end
	end
end
