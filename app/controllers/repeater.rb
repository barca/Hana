def repeat(days, number = 0, start_date, end_date)
    days_of_week = ['m',t','w','th','f','s','sun']
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
