class HouryFee < Fee
  LIMIT_HOUR = 8
  BONUS_RATE = 1.5

  has_many :timecards, inverse_of: :fee, foreign_key: :fee_id

  def calc
    timecards.inject(0) do |m, t|
      m + cost(t.hours)
    end
  end

  private

  def  cost(hour)
    if hour > LIMIT_HOUR
      (hour * 1.5 - LIMIT_HOUR * 0.5) * hourly_rate
    else
      hour * hourly_rate
    end
  end
end
