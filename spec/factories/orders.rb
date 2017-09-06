FactoryGirl.define do
  factory :order do
    subtotal 1.5
    order_number "MyString"
    total 1.5
    order_status nil
    coupon nil
  end
end
