class ByWeeklySchedule < Schedule
  def payday?(date)
    # Returns if date is biweekly friday.
    date.jd % 14 == 4
  end
end
