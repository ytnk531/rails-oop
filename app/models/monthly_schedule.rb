class MonthlySchedule < Schedule
  def payday?(date)
    date == date.end_of_month
  end
end
