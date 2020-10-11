require 'rails_helper'

RSpec.describe 'PaymentFlows', type: :request do
  describe 'payment flows' do
    it 'pays to hourly employee' do
      post '/employees', params: {
        employee: {
          emp_id: 102, name: 'Greatful Man',
          address: 'New York', type: 'H', hourly_rate: 100
        }
      }
      post '/employees/102/timecards', params: {
        timecard: {
          date: '2020/1/1',
          hours: 8
        }
      }
      patch '/employees/102', params: { command: 'Hold' }
      expect do
        post '/paydays', params: { date: '2020/10/9' }
      end.to output("Payed 800 by hold.\n").to_stdout

      expect(response).to have_http_status :success
    end

    it 'pays to monthly employee' do
      post '/employees', params: {
        employee: {
          emp_id: 102, name: 'Greatful Man',
          address: 'New York', type: 'S', monthly_salary: 1200
        }
      }
      patch '/employees/102', params: { command: 'Hold' }
      expect do
        post '/paydays', params: { date: '2020/10/31' }
      end.to output("Payed 1200 by hold.\n").to_stdout

      expect(response).to have_http_status :success
    end
  end
end
