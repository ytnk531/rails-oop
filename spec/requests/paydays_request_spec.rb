require 'rails_helper'

RSpec.describe "Paydays", type: :request do

  describe "GET /create" do
    it "returns http success" do
      get "/paydays/create"
      expect(response).to have_http_status(:success)
    end
  end

end
