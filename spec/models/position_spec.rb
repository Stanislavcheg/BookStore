require 'rails_helper'

RSpec.describe Position, type: :model do
let(:position) { FactoryGirl.create(:position) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'instance methods' do
    context 'when instance saved' do
      describe 'finalize' do
        it 'sets unit_price property' do
          expect(position.unit_price).to eq(position.book.price)
        end

        it 'sets total price' do
          expect(position.total_price).to eq(position.unit_price*position.quantity)
        end
      end
    end
  end
end
