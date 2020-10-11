require 'rails_helper'

RSpec.describe ByWeeklySchedule, type: :model do
  let!(:tested) { described_class.new }

  it 'a' do
    expect(tested.payday?(Date.parse('2020/10/9'))).to be true
    expect(tested.payday?(Date.parse('2020/10/10'))).to be false
    expect(tested.payday?(Date.parse('2020/10/16'))).to be false
    expect(tested.payday?(Date.parse('2020/10/23'))).to be true
  end
end
