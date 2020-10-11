class MonthlyFee < Fee
  def calc
    monthly_salary
  end

  def schedule
    @schedule ||= MonthlySchedule.new
  end
end
