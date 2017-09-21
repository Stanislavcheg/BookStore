FactoryGirl.define do
  factory :author do
    sequence(:first_name) { |n| FFaker::Name.first_name + n.to_s }
    last_name { FFaker::Name.last_name }
  end
end
