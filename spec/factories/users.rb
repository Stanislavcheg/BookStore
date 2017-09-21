FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    password 'password'
    password_confirmation "password"
    confirmed_at DateTime.now

    factory :user_with_address do
      billing_address { create(:billing_address, addressable_type: "User") }
      shipping_address { create(:shipping_address, addressable_type: "User") }
    end

    factory :user_with_orders do
      transient do
        orders_count 3
      end

      after(:create) do |user, evaluator|
        create_list(:order_with_positions, evaluator.orders_count, user: user)
      end
    end
  end
end
