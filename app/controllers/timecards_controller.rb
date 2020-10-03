class TimecardsController < ApplicationController
  def create
    set_employee
    fee = @employee.fee
    Timecard.new(fee: fee)
    fee.timecards.create(timecard_params)
  end

  private

  def set_employee
    @employee = Employee.find(params[:employee_id])
  end

  def timecard_params
    params.require(:timecard).permit(:date, :hours)
  end
end
