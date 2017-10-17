class AddressesForm < Rectify::Form
  attribute :billing_address, BillingAddressForm
  attribute :shipping_address, ShippingAddressForm

  def save
    return false if invalid?
    billing_address.save && shipping_address.save
  end
end
