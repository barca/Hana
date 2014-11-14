module LessonsHelper
	def lessonsOn(date, lessons)
		days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
		dayOfWeek = days_of_week[(date.wday)]
		if dayOfWeek == "sun" || dayOfWeek == "sat"
			return lessons.where(starts_at: date.beginning_of_day..date.end_of_day)
		else
			#return lessons.find_by_sql("SELECT * FROM lessons WHERE #{dayOfWeek} = true OR starts_at BETWEEN #{date.beginning_of_day} AND #{date.end_of_day}")
			#lessonsOnDate = lessons.where(starts_at: date.beginning_of_day..date.end_of_day)
			return lessons.where(dayOfWeek.to_sym => true)
			#return lessonsOnDate.merge(lessonsOnDay)
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
