class ApplicationController < ActionController::Base
  def set_employee
    @employee = Employee.find(params[:employee_id])
  end
end
