FactoryGirl.define do
  factory :order do
    subtotal 1.5
    order_number { 'R' + FFaker::Random.rand(10000000..99999999).to_s }
    total 1.5

    factory :order_with_positions do
      transient do
        positions_count 3
      end

      after(:build) do |order, evaluator|
        order.positions << FactoryGirl.create_list(:position, evaluator.positions_count, order: order)
      end
    end
  end
end
