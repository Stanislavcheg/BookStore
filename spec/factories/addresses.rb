FactoryGirl.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::AddressUS.street_name }
    city { FFaker::AddressUS.city }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country_code }
    phone { FFaker::PhoneNumber.phone_number }
  end

  factory :billing_address, class: BillingAddress, parent: :address do
    type "BillingAddress"
  end

  factory :shipping_address, class: ShippingAddress, parent: :address do
    type "ShippingAddress"
  end
end
