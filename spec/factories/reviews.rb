FactoryGirl.define do
  factory :review do
    title "MyString"
    description "MyText"
    rating 1
    status "MyString"
    book nil
    user nil
  end
end
