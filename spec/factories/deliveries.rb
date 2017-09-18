FactoryGirl.define do
  factory :delivery do
    days { FFaker::Random.rand(10).to_s + ' days' }
    price { FFaker::Random.rand(100) }
    after(:build) { |delivery| delivery.method = 'Standard Shipping' }
  end
end
