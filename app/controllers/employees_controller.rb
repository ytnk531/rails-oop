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

  def update
    set_employee
    command = params[:command]
    case command
    when 'Name'
      @employee.update(name: params[:name])
    when 'Address'
      @employee.update(address: params[:address])
    when 'Hourly'
      @employee.fee = HouryFee.new(hourly_rate: params[:hourly_rate])
      @employee.save
    when 'Salaried'
      @employee.fee = MonthlyFee.new(monthly_salary: params[:salary])
    when 'Commission'
      @employee.fee = CommissionFee.new(monthly_salary: params[:salary],
                                        commission_rate: params[:rate])
    when 'Hold'
      @employee.payment_method = HoldPaymentMethod.new
      @employee.save!
    when 'Direct'
      @employee.payment_method = DirectPaymentMethod.new(bank: params[:bank],
                                                         account: params[:account], employee: @employee)
      @employee.save!
    when 'Mail'
      @employee.payment_method = MailPaymentMethod.new(address: params[:address])
      @employee.save!
    when 'Member'
      @employee.affiliation = Affiliation.new(member_id: params[:member_id],
                                              due: params[:rate])
      @employee.save
    when 'NoMember'
      @employee.affiliation.destroy
    end
  end

  private

  def employee_params
    params.require(:employee)
          .permit(
            :emp_id, :name, :address, :type,
            :hourly_rate, :monthly_salary, :commission_rate
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
