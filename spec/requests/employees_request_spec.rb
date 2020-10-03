require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  describe 'POST' do
    it 'creates hourly employee and returns http success' do
      post '/employees', params: {
        employee: {
          emp_id: 1, name: 'Greatful Man',
          address: 'New York', type: 'H', hourly_rate: 100
        }
      }

      expect(Employee.count).to eq 1
      employee = Employee.first
      expect(employee).to have_attributes(
        id: 1, name: 'Greatful Man',
        address: 'New York'
      )
      expect(employee.fee).to have_attributes(hourly_rate: 100)
      expect(response).to have_http_status(:success)
    end

    it 'creates monthly employee and returns http success' do
      post '/employees', params: {
        employee: {
          emp_id: 1, name: 'Greatful Man',
          address: 'New York', type: 'S', monthly_salary: 100
        }
      }

      expect(Employee.count).to eq 1
      employee = Employee.first
      expect(employee).to have_attributes(
        id: 1, name: 'Greatful Man',
        address: 'New York'
      )
      expect(employee.fee).to have_attributes(monthly_salary: 100)
      expect(response).to have_http_status(:success)
    end

    it 'creates monthly employee and returns http success' do
      post '/employees', params: {
        employee: {
          emp_id: 1, name: 'Greatful Man',
          address: 'New York', type: 'C',
          monthly_salary: 100, commission_rate: 102
        }
      }

      expect(Employee.count).to eq 1
      employee = Employee.first
      expect(employee).to have_attributes(
        id: 1, name: 'Greatful Man',
        address: 'New York'
      )
      expect(employee.fee).to have_attributes(monthly_salary: 100,
                                              commission_rate: 102)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE' do
    it 'returns http success' do
      Employee.create(id: 1)
      Employee.create(id: 2)
      delete '/employees/1'

      expect(Employee.count).to eq 1
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /employees/:id/timecards' do
    it 'returns http success' do
      fee = HouryFee.new(hourly_rate: 200)
      Employee.create(id: 1, fee: fee)
      post '/employees/1/timecards', params: {
        timecard: {
          date: '2020/1/1',
          hours: 8
        }
      }

      expect(Timecard.first).to have_attributes(
        fee: fee,
        date: '2020/1/1'.in_time_zone,
        hours: 8
      )
      expect(response).to have_http_status(:success)
    end
  end
end
