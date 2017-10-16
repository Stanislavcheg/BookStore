require 'rails_helper'

RSpec.describe PaymentForm do
  describe 'validations' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:number) }
      it { is_expected.to validate_presence_of(:expires) }
      it { is_expected.to validate_presence_of(:name) }
    end

    context 'format' do
      context 'valid' do
        it { is_expected.to allow_value('1234567890123456').for(:number) }
        it { is_expected.to allow_value('123').for(:cvv) }
        it { is_expected.to allow_value('1234').for(:cvv) }
        it { is_expected.to allow_value('John Doe').for(:name) }
        it { is_expected.to allow_value('John').for(:name) }
        it { is_expected.to allow_value('01/11').for(:expires) }
        it { is_expected.to allow_value('11/01').for(:expires) }
      end
      context 'invalid' do
        it { is_expected.to_not allow_value('123456789012345').for(:number) }
        it { is_expected.to_not allow_value('12345678901234567').for(:number) }
        it { is_expected.to_not allow_value('123456789A123456').for(:number) }
        it { is_expected.to_not allow_value('123456789a123456').for(:number) }

        it { is_expected.to_not allow_value('12345').for(:cvv) }
        it { is_expected.to_not allow_value('12').for(:cvv) }
        it { is_expected.to_not allow_value('abc').for(:cvv) }
        it { is_expected.to_not allow_value('ABC').for(:cvv) }

        it { is_expected.to_not allow_value('John1 Doe').for(:name) }
        it { is_expected.to_not allow_value('John! Doe').for(:name) }

        it { is_expected.to_not allow_value('13/01').for(:expires) }
        it { is_expected.to_not allow_value('1/01').for(:expires) }
        it { is_expected.to_not allow_value('1101').for(:expires) }
        it { is_expected.to_not allow_value('11 01').for(:expires) }
        it { is_expected.to_not allow_value('11/a1').for(:expires) }
        it { is_expected.to_not allow_value('1a/11').for(:expires) }
      end
    end
  end
end
