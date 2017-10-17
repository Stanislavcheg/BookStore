FactoryGirl.define do
  factory :book do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
    authors { |a| [a.association(:author)] }
    category
    year { FFaker::Random.rand(1990..2017) }
    height { FFaker::Random.rand(0.1..10) }
    width { FFaker::Random.rand(0.1..10) }
    depth { FFaker::Random.rand(0.1..10) }
    price { FFaker::Random.rand(1..100) }
    materials "Hardcove, glossy pape"

    factory :book_with_positions do
      transient do
        positions_count 3
      end

      after(:create) do |book, evaluator|
        create_list(:position, evaluator.positions_count, book: book)
      end
    end
  end
end
