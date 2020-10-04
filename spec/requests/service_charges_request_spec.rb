require 'rails_helper'

RSpec.describe 'ServiceCharges', type: :request do
  describe 'POST /service_charges' do
    it 'returns 200' do
      Employee.create(affiliation: Affiliation.new)
      post '/service_charges', params: {
        service_charge: {
          mebmer_id: '123',
          amount: 100
        }
      }

      expect(ServiceCharge.count).to eq 1
      expect(response).to have_http_status(:success)
    end
  end
end
