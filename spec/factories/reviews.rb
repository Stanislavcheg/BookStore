FactoryGirl.define do
  factory :review do
    title { user.name || "MyString" }
    description "MyText"
    rating 5
    status "Review status"
    book
    user
  end
end
