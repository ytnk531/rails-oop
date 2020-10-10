module ChangeCommand
  module_function

  # Returns corresponding command class
  def build(task_name, params)
    class_name = "ChangeCommand::ChangeEmployee#{task_name}Command"
    class_name.constantize
              .new(params.delete(:id), params.dup)
  end

  class ChangeEmployeeCommand
    def initialize(employee_id, opts)
      @employee_id = employee_id
      process_opts(opts)
    end

    def run
      employee = Employee.find(@employee_id)
      change(employee)
    end

    def process_opts(_opts); end
  end

  class ChangeEmployeeNameCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_name = opts[:name]
    end

    def change(employee)
      employee.update(name: @new_name)
    end
  end

  class ChangeEmployeeAddressCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_address = opts[:address]
    end

    def change(employee)
      employee.update(address: @new_address)
    end
  end

  class ChangeEmployeeHourlyCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_rate = opts[:hourly_rate]
    end

    def change(employee)
      employee.fee&.destroy
      employee.update!(fee: HouryFee.new(hourly_rate: @new_rate))
    end
  end

  class ChangeEmployeeSalariedCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_salary = opts[:salary]
    end

    def change(employee)
      employee.fee&.destroy
      employee.update(fee: MonthlyFee.new(monthly_salary: @new_salary))
    end
  end

  class ChangeEmployeeCommissionCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_salary = opts[:salary]
      @new_commission_rate = opts[:rate]
    end

    def change(employee)
      employee.fee&.destroy
      employee.update(fee: CommissionFee.new(
        monthly_salary: @new_salary,
        commission_rate: @new_commission_rate
      ))
    end
  end

  class ChangeEmployeeHoldCommand < ChangeEmployeeCommand
    def change(employee)
      employee.payment_method&.destroy
      employee.update(payment_method: HoldPaymentMethod.new)
    end
  end

  class ChangeEmployeeDirectCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @bank = opts[:bank]
      @account = opts[:account]
    end

    def change(employee)
      employee.payment_method&.destroy
      employee.update(payment_method: DirectPaymentMethod.new(bank: @bank,
                                                              account: @account))
    end
  end

  class ChangeEmployeeMailCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @address = opts[:address]
    end

    def change(employee)
      employee.payment_method&.destroy
      employee.update(payment_method: MailPaymentMethod.new(address: @address))
    end
  end

  class ChangeEmployeeMemberCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @member_id = opts[:member_id]
      @rate = opts[:rate]
    end

    def change(employee)
      employee.update(affiliation: Affiliation.new(member_id: @member_id,
                                                   due: @rate))
    end
  end

  class ChangeEmployeeNoMemberCommand < ChangeEmployeeCommand
    def change(employee)
      employee.affiliation.destroy
    end
  end
end
