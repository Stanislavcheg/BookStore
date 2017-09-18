FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'Password'
    confirmed_at DateTime.now
    association :billing_address, factory: :billing_address, strategy: :build
    association :shipping_address, factory: :shipping_address, strategy: :build
  end
end
