require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:rating) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
    it { is_expected.to validate_length_of(:description).is_at_most(500) }
    it { is_expected.to validate_length_of(:title).is_at_most(80) }

    context 'format' do
      context 'valid' do
        it { is_expected.to allow_value("AarZ45 dff!#$%&'*+/=?^_`{|}~.,-").for(:title) }
        it { is_expected.to allow_value("AarZ45 dff!#$%&'*+/=?^_`{|}~.,-").for(:description) }
      end
      context 'invalid' do
        it { is_expected.to_not allow_value("AarZ45 dff@").for(:title) }
        it { is_expected.to_not allow_value("AarZ45 dff@").for(:description) }
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'instance methods' do
    let(:review) { FactoryGirl.create(:review) }

    describe 'date' do
      it 'displays review date in "mm/dd/yy" format' do
        expect(review.date).to match(/\A(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])\/\d\d\z/)
      end
    end

    describe 'verified?' do
      it 'shows true if user bought the book' do
        order = FactoryGirl.create(:order)
        order.positions << FactoryGirl.create(:position, book: review.book)
        order.positions << FactoryGirl.create(:position)
        order.user = review.user
        order.order_status = "delivered"
        order.save
        expect(review.verified?).to be_truthy
      end

      it "shows false if user didn't buy the book" do
        expect(review.verified?).to be_falsey
      end
    end
  end
end
