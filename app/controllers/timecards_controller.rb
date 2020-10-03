class TimecardsController < ApplicationController
  def create
    set_employee
    fee = @employee.fee
    fee.timecards.create(timecard_params)
  end

  private

  def timecard_params
    params.require(:timecard).permit(:date, :hours)
  end
end
