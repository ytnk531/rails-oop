class EmployeesController < ApplicationController
  def create
    command = Command.build_create(employee_params)
    command.run
  end

  def destroy
    set_employee
    @employee.destroy
  end

  def update
    command = Command.build(params[:command], params)
    command.run
  end

  private

  def employee_params
    params.require(:employee)
          .permit(
            :emp_id, :name, :address, :type,
            :hourly_rate, :monthly_salary, :commission_rate
          )
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
