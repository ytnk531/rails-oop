class HoldPaymentMethod < PaymentMethod
  def pay(fee)
    puts "Payed #{fee} by hold."
  end
end
