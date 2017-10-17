require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:books) }
  end

  describe 'instance methods' do
    let(:category_with_books) { FactoryGirl.create(:category_with_books) }
    let(:book_with_positions) { FactoryGirl.create(:book_with_positions) }

    describe 'best_seller' do
      it 'displays most popular book' do
        category_with_books.books << book_with_positions
        expect(category_with_books.best_seller).to eq(book_with_positions)
      end
    end
  end
end
