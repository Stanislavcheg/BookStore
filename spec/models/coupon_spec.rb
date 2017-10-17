require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_uniqueness_of(:code) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:orders) }
  end

  describe 'instance methods' do
    let(:coupon) { FactoryGirl.create(:coupon) }

    describe 'to_s' do
      it 'displays string with code and discount' do
        coupon.code = 'test'
        coupon.discount = 15.11
        expect(coupon.to_s).to eq("code: test, discount: 15.11")
      end
    end
  end
end
