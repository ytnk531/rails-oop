class Affiliation < ApplicationRecord
  belongs_to :employee
  has_many :service_charges

  def cost
    service_charges.sum(:amount) + due
  end
end
