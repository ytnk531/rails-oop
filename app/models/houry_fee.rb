class HouryFee < Fee
  has_many :timecards, inverse_of: :fee, foreign_key: :fee_id
end
