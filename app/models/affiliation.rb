class Affiliation < ApplicationRecord
  belongs_to :employee
  has_many :service_charges

  def cost
    service_charges.sum(:amount) + due
  end

  def self.nothing
    Struct.new(:cost) do
      def nil?
        true
      end
    end.new(0)
  end
end
