require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:reviews) }
  end

  describe 'instance methods' do
    let(:user) { FactoryGirl.create(:user) }

    describe 'last_order' do
      it 'returns last created order' do
        order1 = FactoryGirl.create(:order)
        order2 = FactoryGirl.create(:order)
        user.orders << [order1, order2]

        expect(user.last_order).to eq(order2)
      end
    end
  end
end
