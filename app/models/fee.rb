class Fee < ApplicationRecord
  belongs_to :employee

  def payday?(_date)
    true
  end
end
