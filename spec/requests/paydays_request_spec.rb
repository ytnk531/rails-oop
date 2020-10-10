require 'rails_helper'

RSpec.describe 'Paydays', type: :request do
  describe 'POST /paydays' do
    it 'returns http success' do
      Employee.create(
        affiliation: Affiliation.new(
          due: 123,
          service_charges: [
            ServiceCharge.new(amount: 100)
          ]
        ),
        fee: HouryFee.new(hourly_rate: 120,
                          timecards: [
                            Timecard.new(hours: 8)
                          ]),
        payment_method: HoldPaymentMethod.new
      )
      post '/paydays', params: { date: '2020/1/1' }

      expect(response).to have_http_status :success
    end
  end
end
