class AddressesForm < Rectify::Form
  attribute :billing_address, BillingAddressForm
  attribute :shipping_address, ShippingAddressForm

  def save
    if valid?
      billing_address.save
      shipping_address.save
      return true
    end
    false
  end
end
