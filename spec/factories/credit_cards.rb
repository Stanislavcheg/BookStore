FactoryGirl.define do
  factory :credit_card do
    number '1234567890123456'
    name { "John Doe" }
    expires '10/20'
    cvv 111
    order
  end
end
