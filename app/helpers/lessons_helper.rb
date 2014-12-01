module LessonsHelper
	#find lessons occuring on a given day
	def lessonsOn(date, classes, grade_level)
		dayTomorrow = (date + 1)
		dayYesterday = (date - 1)
    	classes = classes.where("\"lessons\".\"starts_at\" < ?", date + 1)
    	classes = classes.where("\"lessons\".\"end_date\" > ?" , date - 1)

		days_of_week = ["sun","mon", "tue", "wed", "thu", "fri","sat"]
		dayOfWeek = days_of_week[(date.wday)]
		if dayOfWeek == "sun" || dayOfWeek == "sat"
			#classes don't reccur on weekends
			return classes.where(starts_at: date.beginning_of_day..date.end_of_day).order(:starts_at)
		else
			dayStart = "#{date.strftime("%Y-%m-%d")} 05:00:00.000000"
			dayTomorrow = date + 1
			dayEnd = "#{dayTomorrow.strftime("%Y-%m-%d")} 04:59:59.999999"
			#SQL to return lessons for the appropriate grade level that occur on a given day
			return classes.find_by_sql("SELECT * FROM \"lessons\"  
												WHERE (\"lessons\".\"#{grade_level}\" = \'t\' 
													AND (\"lessons\".\"start_date\" < \'#{dayTomorrow}\') 
													AND (\"lessons\".\"start_date\" > \'#{dayYesterday}\') 
														OR (\"lessons\".\"#{dayOfWeek}\" = \'t\'))
												ORDER BY TIME(\"lessons\".\"starts_at\")")
		end
	end
end 