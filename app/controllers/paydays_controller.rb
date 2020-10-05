class PaydaysController < ApplicationController
  def create
    employees = Employee.payday(params[:date])
    employees.each(&:pay)
  end
end
