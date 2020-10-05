class Employee < ApplicationRecord
  has_one :fee
  has_one :affiliation
  has_one :payment_method

  def self.payday(date)
    Employee.all.filter { _1.payday?(date) }
  end

  def pay
    feel = fee.calc
    cost = affiliation.cost
    payment = feel - cost
    payment_method.pay(payment)
  end

  def payday?(date)
    fee.payday?(date)
  end
end
