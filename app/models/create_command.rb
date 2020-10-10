module CreateCommand
  MARK_AND_FEE_KIND = {
    'H': 'Hourly',
    'S': 'Monthly',
    'C': 'Commission'
  }.freeze

  module_function

  def build(params)
    d = params.dup
    fee_kind = MARK_AND_FEE_KIND[d.delete(:type).to_sym]
    klass = "CreateCommand::Create#{fee_kind}EmployeeCommand"

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
        fee: fee,
        payment_method: HoldPaymentMethod.new
      )
      e.save!
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
end
