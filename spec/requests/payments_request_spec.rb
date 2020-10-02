require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  describe 'POST /payday' do
    it 'returns http success' do
      post '/payments/payday', params: { id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /add_emp' do
    it 'returns http success' do
      post '/payments/add', params: {}
      expect(response).to have_http_status(:success)
    end
  end
end
