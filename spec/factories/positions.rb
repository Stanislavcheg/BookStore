FactoryGirl.define do
  factory :position do
    book
    order
    quantity { FFaker::Random.rand(1..10) }
  end
end
