module Command
  module_function

  MARK_AND_FEE_KIND = {
    'H': 'Hourly',
    'S': 'Monthly',
    'C': 'Commission'
  }.freeze

  # Returns corresponding command class
  def build(task_name, params)
    class_name = "Command::ChangeEmployee#{task_name}Command"
    class_name.constantize
              .new(params.delete(:id), params)
  end

  def build_create(params)
    d = params.dup
    fee_kind = MARK_AND_FEE_KIND[d.delete(:type).to_sym]
    klass = "Command::Create#{fee_kind}EmployeeCommand"

    klass.constantize.new(d.delete(:emp_id),
                          d.delete(:name),
                          d.delete(:address), d)
  end

  class CreateEmployeeCommand
    def initialize(employee_id, name, address, opts)
      @employee_id = employee_id
      @name = name
      @address = address
      process_opts(opts)
    end

    def run
      e = Employee.new(
        id: @employee_id,
        name: @name,
        address: @address,
        fee: fee
      )
      e.save
    end
  end

  class CreateHourlyEmployeeCommand < CreateEmployeeCommand
    def process_opts(opts)
      @hourly_rate = opts[:hourly_rate]
    end

    def fee
      HouryFee.new(hourly_rate: @hourly_rate)
    end
  end

  class CreateMonthlyEmployeeCommand < CreateEmployeeCommand
    def process_opts(opts)
      @monthly_salary = opts[:monthly_salary]
    end

    def fee
      MonthlyFee.new(monthly_salary: @monthly_salary)
    end
  end

  class CreateCommissionEmployeeCommand < CreateEmployeeCommand
    def process_opts(opts)
      @monthly_salary = opts[:monthly_salary]
      @commission_rate = opts[:commission_rate]
    end

    def fee
      CommissionFee.new(monthly_salary: @monthly_salary,
                        commission_rate: @commission_rate)
    end
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
      employee.update!(fee: HouryFee.new(hourly_rate: @new_rate))
    end
  end

  class ChangeEmployeeSalariedCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_salary = opts[:salary]
    end

    def change(employee)
      employee.update(fee: MonthlyFee.new(monthly_salary: @new_salary))
    end
  end

  class ChangeEmployeeCommissionCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @new_salary = opts[:salary]
      @new_commission_rate = opts[:rate]
    end

    def change(employee)
      employee.update(fee: CommissionFee.new(
        monthly_salary: @new_salary,
        commission_rate: @new_commission_rate
      ))
    end
  end

  class ChangeEmployeeHoldCommand < ChangeEmployeeCommand
    def change(employee)
      employee.update(payment_method: HoldPaymentMethod.new)
    end
  end

  class ChangeEmployeeDirectCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @bank = opts[:bank]
      @account = opts[:account]
    end

    def change(employee)
      employee.update(payment_method: DirectPaymentMethod.new(bank: @bank,
                                                              account: @account))
    end
  end

  class ChangeEmployeeMailCommand < ChangeEmployeeCommand
    def process_opts(opts)
      @address = opts[:address]
    end

    def change(employee)
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
