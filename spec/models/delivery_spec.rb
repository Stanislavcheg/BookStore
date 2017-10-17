require 'rails_helper'

RSpec.describe Delivery, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:method) }
    it { is_expected.to validate_presence_of(:days) }
    it { is_expected.to validate_presence_of(:price) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'instance methods' do
    let(:delivery) { FactoryGirl.create(:delivery) }

    describe 'to_s' do
      it 'should displays delivery method and days formated' do
        days = delivery.days
        method = delivery.method
        expect(delivery.to_s).to eq("#{method} #{days}")
      end
    end
  end
end
