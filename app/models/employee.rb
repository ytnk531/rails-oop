class Employee < ApplicationRecord
  has_one :fee
  has_one :plane_affiliation, class_name: 'Affiliation'
  has_one :payment_method

  def affiliation=(a)
    self.plane_affiliation = a
  end

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
    schedule.payday?(date)
  end

  def schedule
    Schedule.build(self)
  end

  def affiliation
    plane_affiliation || Affiliation.nothing
  end
end
