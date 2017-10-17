require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name) }
  end

  describe 'associations' do
    it { is_expected.to have_and_belong_to_many(:books) }
  end

  describe 'instance methods' do
    let(:author) { FactoryGirl.create(:author) }

    it 'should displays author full name' do
      first_name = author.first_name
      last_name = author.last_name
      expect(author.to_s).to eq("#{first_name} #{last_name}")
    end
  end
end
