class Affiliation < ApplicationRecord
  belongs_to :employee
  has_many :service_charges
end
