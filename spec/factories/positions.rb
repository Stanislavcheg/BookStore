FactoryGirl.define do
  factory :position do
    book
    order
    unit_price { book.price }
    quantity { FFaker::Random.rand(1..10) }
    total_price { unit_price * quantity }
  end
end
