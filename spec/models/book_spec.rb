require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    context 'field presence' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to validate_presence_of(:description) }
    end

    context 'field numericality rules' do
      it { is_expected.to validate_numericality_of(:height).is_greater_than(0) }
      it { is_expected.to validate_numericality_of(:width).is_greater_than(0) }
      it { is_expected.to validate_numericality_of(:depth).is_greater_than(0) }
      it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
      it { is_expected.to validate_numericality_of(:year).is_greater_than(0) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:authors) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:positions) }
    it { is_expected.to have_many(:reviews) }
  end

  describe 'instance methods' do
    let(:book) { FactoryGirl.create(:book) }

    describe 'short_description' do
      it 'length is less or equal than 100 characters' do
        expect(book.short_description.size).to be <= 100
      end
      it 'is a part of description' do
        expect(book.short_description).to include(book.description[0..80])
      end
    end

    describe 'price_euro' do
      it 'displays price with a euro sign' do
        book.price = 11.112
        expect(book.price_euro).to eq("€11.11")
      end
    end

    describe 'sold_count' do
      it 'counts sold books' do
        position = FactoryGirl.create(:position, quantity: 10)
        book.positions = [position]
        expect(book.sold_count).to eq(10)
      end
    end

    describe 'authors_formated' do
      it 'displays a string with all authors joined with comma' do
        book.authors = [FactoryGirl.create(:author, first_name: 'John', last_name: 'Doe'), FactoryGirl.create(:author, first_name: 'Peter', last_name: 'White')]
        expect(book.authors_formated).to eq('John Doe, Peter White')
      end
    end

    describe 'dimensions' do
      it 'displays formated string with height, width and depth of the book' do
        book.height = 6.53
        book.width = 3
        book.depth = 0.9
        expect(book.dimensions).to eq('H:6.5" x W:3.0" x D:0.9"')
      end
    end
  end
end
