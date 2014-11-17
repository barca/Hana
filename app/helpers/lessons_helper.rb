module LessonsHelper
	def lessonsOn(date, lessons)
    lessons = lessons.where("\"lessons\".\"starts_at\" < ?", date + 1)
    lessons = lessons.where("\"lessons\".\"end_date\" > ?" , date - 1)
		days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
		dayOfWeek = days_of_week[(date.wday)]
		if dayOfWeek == "sun" || dayOfWeek == "sat"
			return lessons.where(starts_at: date.beginning_of_day..date.end_of_day)
		else
			dayStart = "#{date.strftime("%Y-%m-%d")} 05:00:00.000000"
			dayTomorrow = date + 1
			dayEnd = "#{dayTomorrow.strftime("%Y-%m-%d")} 04:59:59.999999"

			return lessons.find_by_sql("SELECT \"lessons\".* FROM \"lessons\"  WHERE (\"lessons\".\"starts_at\" BETWEEN \'#{dayStart}\' AND \'#{dayEnd}\') OR \"lessons\".\"#{dayOfWeek}\" = \'t\'")

			#Lesson.where(starts_at: Date.today.beginning_of_day..Date.today.end_of_day)
			#SELECT "lessons".* FROM "lessons"  WHERE "lessons"."mon" = 't'
			#SELECT "lessons".* FROM "lessons"  WHERE ("lessons"."starts_at" BETWEEN '' '2014-11-16 05:00:00.000000' AND '2014-11-17 04:59:59.999999') OR
			#return lessons.find_by_sql("SELECT * FROM lessons WHERE #{dayOfWeek} = true OR starts_at BETWEEN #{date.beginning_of_day} AND #{date.end_of_day}")
			#lessonsOnDate = lessons.where(starts_at: date.beginning_of_day..date.end_of_day)
			#return lessons.where(dayOfWeek.to_sym => true)
			#Lesson.where(mon => true)
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
