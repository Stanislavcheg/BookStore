require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
  end

  describe 'instance methods' do
    let(:card) { FactoryGirl.create(:credit_card) }

    describe 'masked_number' do
      it 'shows only last 4 digits of credit number' do
        card.number = '1234567890123456'
        expect(card.decorate.masked_number).to eq("**** **** **** 3456")
      end
    end
  end
end
