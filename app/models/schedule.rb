class Schedule
  def self.build(employee)
    employee.fee.schedule
  end

  def payday?(date); end
end
