class SalesReceiptsController < ApplicationController
  def create
    set_employee
    fee = @employee.fee
    fee.sales_receipts.create(sales_receipt_params)
  end

  private

  def sales_receipt_params
    params.require(:sales_receipt).permit(:date, :amount)
  end
end
