class Employee < ApplicationRecord
  has_one :fee
  has_one :affiliation
  has_one :payment_method
end
