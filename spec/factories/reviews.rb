FactoryGirl.define do
  factory :review do
    description "MyText"
    rating 5
    status "Review status"
    book
    user
    after(:build) { |review| review.title = review.user.name || "anonymous" }
  end
end
