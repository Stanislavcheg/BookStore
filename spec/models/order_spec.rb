require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { FactoryGirl.create(:order) }
  let(:order_with_positions) { FactoryGirl.create(:order_with_positions) }
  let(:position) { FactoryGirl.create(:position) }

  describe 'associations' do
    it { is_expected.to belong_to(:coupon) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:delivery) }
    it { is_expected.to have_many(:positions) }
    it { is_expected.to have_one(:billing_address) }
    it { is_expected.to have_one(:shipping_address) }
    it { is_expected.to have_one(:credit_card) }
  end

  describe 'instance methods' do
    context 'when instance created' do
      it 'sets status to pending' do
        expect(order.order_status).to eq("in_progress")
      end

      it 'sets order number' do
        expect(order.order_number).not_to be_nil
      end
    end

    context 'when positions changes' do
      it 'updates subtotal' do
        subtotal_before = order.subtotal
        order.positions << position
        expect(order.subtotal).not_to eq(subtotal_before)
      end

      it "sets subtotal as a sum of position's prices" do
        position2 = FactoryGirl.create(:position)
        order.positions << [position, position2]
        order.save
        expect(order.subtotal).to eq(position.total_price + position2.total_price)
      end

      it 'updates total' do
        total_before = order.total
        order.positions << position
        order.save
        expect(order.total).not_to eq(total_before)
      end

      it "sets total as a sum of subtotal and delivery costs" do
        order_with_positions.delivery = FactoryGirl.create(:delivery)
        order.reload
        expect(order_with_positions.total).to eq(order_with_positions.subtotal +
        order_with_positions.delivery.price)
      end

      it 'calculates the discount if coupon is present' do
        order_with_positions.coupon = FactoryGirl.create(:coupon)
        order.reload
        expect(order_with_positions.total).to eq(order_with_positions.subtotal -
        order_with_positions.subtotal*order_with_positions.coupon.discount)
      end
    end

    describe 'includes_book?' do
      context 'when book is present in the order' do
        it 'returns true' do
          order.positions << position
          expect(order.includes_book? position.book).to be_truthy
        end
      end
      context 'when there is no such book' do
        it 'returns false' do
          expect(order.includes_book? position.book).to be_falsey
        end
      end
    end
  end
  describe 'decorators methods' do
    it 'returns available statuses to change' do
      expect(order_with_positions.decorate.available_statuses).to match_array(['in_queue', 'in_delivery', 'canceled'])
    end

    it 'returns formated string with order info' do
      expect(order_with_positions.decorate.name).to eq("Order: #{order_with_positions.order_number} #{order_with_positions.order_status}")
    end

    it 'returns formated string with order updated info' do
      expect(order_with_positions.decorate.updated_at_formated).to eq(order_with_positions.updated_at.strftime("%F"))
    end
  end
end
