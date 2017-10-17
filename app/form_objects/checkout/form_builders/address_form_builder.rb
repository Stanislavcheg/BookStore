class AddressFormBuilder
  def self.build_from_model(current_user, current_order)
    billing_address = BillingAddressForm.from_model(current_order
      .billing_address || current_user.billing_address || BillingAddress.new)
    shipping_address = ShippingAddressForm.from_model(current_order
      .shipping_address || current_user.shipping_address || ShippingAddress.new)
    AddressesForm.new(billing_address: billing_address, shipping_address: shipping_address)
  end
end
