class WeeklySchedule < Schedule
  def payday?(date)
    date.friday?
  end
end
