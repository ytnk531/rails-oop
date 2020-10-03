require 'rails_helper'

RSpec.describe 'SalesReceipts', type: :request do
  describe 'POST employees/:employee_id/sales_receipts' do
    it 'returns HTTP success' do
      fee = CommissionFee.new(monthly_salary: 100, commission_rate: 243)
      Employee.create(id: 1, fee: fee)
      post '/employees/1/sales_receipts', params: {
        sales_receipt: {
          date: '2021/10/1',
          amount: 100
        }
      }
      expect(SalesReceipt.first).to have_attributes(
        fee: fee,
        date: '2021/10/1'.in_time_zone,
        amount: 100
      )
      expect(response).to have_http_status(:success)
    end
  end
end
