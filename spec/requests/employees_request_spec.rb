require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  describe 'POST' do
    it 'creates employee and returns http success' do
      post '/employees', params: {
        id: 1, name: 'Greatful Man',
        address: 'New York', type: 'H', hourly_rate: 100
      }

      expect(Employee.count).to eq 1
      expect(Employee.first).to have_attributes(
        id: 1, name: 'Greatful Man',
        address: 'New York', type: 'H', hourly_rate: 100
      )
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE' do
    it 'returns http success' do
      Employee.create(id: 1)
      Employee.create(id: 2)
      delete '/employees', params: { id: 1 }

      expect(Employee.count).to eq 1
      expect(response).to have_http_status(:success)
    end
  end
end
