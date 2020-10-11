class PaydaysController < ApplicationController
  def create
    employees = Employee.payday(Date.parse(params[:date]))
    employees.each(&:pay)
  end
end
