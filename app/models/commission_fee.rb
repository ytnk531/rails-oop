class CommissionFee < Fee
  has_many :sales_receipts, inverse_of: :fee, foreign_key: :fee_id

  def schedule
    @schedule ||= ByWeeklySchedule.new
  end
end
