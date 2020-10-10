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

  describe 'PATCH /employees/:id/' do
    it 'updates Name' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Name', name: 'newName' }
      expect(Employee.find(1)).to have_attributes(name: 'newName')
    end

    it 'updates Address' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Address',
                                      address: 'newAddress' }
      expect(Employee.find(1)).to have_attributes(address: 'newAddress')
    end

    it 'updates Hourly' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Hourly', hourly_rate: 123 }
      expect(Employee.find(1).fee).to have_attributes(hourly_rate: 123)
    end

    it 'updates Salaried' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Salaried', salary: 102 }
      expect(Employee.find(1).fee).to have_attributes(monthly_salary: 102)
    end

    it 'updates Commission' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Commission', salary: 102,
                                      rate: 12 }
      expect(Employee.find(1).fee).to have_attributes(monthly_salary: 102,
                                                      commission_rate: 12)
    end

    it 'updates Hold' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Hold' }
      expect(Employee.find(1).payment_method).to be_a HoldPaymentMethod
    end

    it 'updates Direct' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Direct', bank: 'good bank',
                                      account: 'good bank account' }
      expect(Employee.find(1).payment_method).to have_attributes(
        bank: 'good bank', account: 'good bank account'
      )
    end

    it 'updates Mail' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Mail', address: 'ad' }
      expect(Employee.find(1).payment_method).to have_attributes(address: 'ad')
    end

    it 'updates Member' do
      Employee.create(id: 1, name: 'National')
      patch '/employees/1', params: { command: 'Member', rate: 400 }
      expect(Employee.find(1).affiliation).to have_attributes(due: 400)
    end

    it 'updates NoMember' do
      Employee.create(id: 1, name: 'National', affiliation: Affiliation.new)
      patch '/employees/1', params: { command: 'NoMember' }
      expect(Employee.find(1).affiliation).to be_nil
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
