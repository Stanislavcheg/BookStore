FactoryGirl.define do
  factory :category do
    sequence(:name) { |i| "Category" + i.to_s }

    factory :category_with_books do
      transient do
        books_count 3
      end

      after(:create) do |category, evaluator|
        create_list(:book, evaluator.books_count, category: category)
      end
    end
  end
end
