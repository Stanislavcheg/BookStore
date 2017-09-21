require 'rails_helper'

RSpec.describe AddressForm do
  describe 'validations' do
    context 'field presence' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:address) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:zip) }
      it { is_expected.to validate_presence_of(:country) }
      it { is_expected.to validate_presence_of(:phone) }
    end

    context 'length' do
      it { is_expected.to validate_length_of(:first_name).is_at_most(50) }
      it { is_expected.to validate_length_of(:last_name).is_at_most(50) }
      it { is_expected.to validate_length_of(:address).is_at_most(50) }
      it { is_expected.to validate_length_of(:city).is_at_most(50) }
      it { is_expected.to validate_length_of(:country).is_at_most(50) }
      it { is_expected.to validate_length_of(:phone).is_at_most(15) }
      it { is_expected.to validate_length_of(:zip).is_at_most(10) }
    end

    context 'format' do
      context 'valid' do
        it { is_expected.to allow_value('John').for(:first_name) }
        it { is_expected.to allow_value('Doe').for(:last_name) }
        it { is_expected.to allow_value('New York').for(:city) }
        it { is_expected.to allow_value('United States').for(:country) }
        it { is_expected.to allow_value("Abc-bca's street 21").for(:address) }
        it { is_expected.to allow_value('111-333').for(:zip) }
        it { is_expected.to allow_value('+380971231212').for(:phone) }
      end
      context 'invalid' do
        it { is_expected.to_not allow_value('John Johnovich').for(:first_name) }
        it { is_expected.to_not allow_value('John1').for(:first_name) }
        it { is_expected.to_not allow_value('Doe doe').for(:last_name) }
        it { is_expected.to_not allow_value('Doe2').for(:last_name) }
        it { is_expected.to_not allow_value('Los Angeles1').for(:city) }
        it { is_expected.to_not allow_value('United States1').for(:country) }
        it { is_expected.to_not allow_value('Some street @').for(:address) }
        it { is_expected.to_not allow_value('1111a').for(:zip) }
        it { is_expected.to_not allow_value('380971231212').for(:phone) }
        it { is_expected.to_not allow_value('+38097123121a').for(:phone) }
      end
    end
  end
end
