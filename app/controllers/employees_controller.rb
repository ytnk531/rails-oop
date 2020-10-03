class EmployeesController < ApplicationController
  def create
    Employee.create(
      id: employee_params[:emp_id],
      name: employee_params[:name],
      address: employee_params[:address],
      fee: fee(employee_params)
    )
  end

  def destroy
    set_employee
    @employee.destroy
  end

  private

  def employee_params
    params.require(:employee)
          .permit(
            :emp_id, :name, :address, :type, :hourly_rate, :monthly_salary, :commission_rate
          )
  end

  def fee(employee_params)
    case employee_params[:type]
    when 'H'
      HouryFee.new(hourly_rate: employee_params[:hourly_rate])
    when 'S'
      MonthlyFee.new(monthly_salary: employee_params[:monthly_salary])
    when 'C'
      CommissionFee.new(
        monthly_salary: employee_params[:monthly_salary],
        commission_rate: employee_params[:commission_rate]
      )
    end
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end
end
