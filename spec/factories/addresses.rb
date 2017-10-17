FactoryGirl.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { "Doe" }
    address { FFaker::AddressUS.street_name }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country_code }
    phone "+380972134567"
    addressable_type "User"
    addressable_id { FactoryGirl.create(:user).id }
  end

  factory :billing_address, class: BillingAddress, parent: :address do
    type "BillingAddress"
  end

  factory :shipping_address, class: ShippingAddress, parent: :address do
    type "ShippingAddress"
  end
end
