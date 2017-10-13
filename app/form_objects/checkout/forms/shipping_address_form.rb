class ShippingAddressForm < AddressForm
  def save
    return false if invalid?
    persist!
  end

  private

  def persist!
    order = context.order
    if order.shipping_address
      order.shipping_address.update_attributes(address_params)
    else
      shipping_address = ShippingAddress.new(address_params)
      shipping_address.addressable_type = "Order"
      shipping_address.addressable_id = order.id
      shipping_address.save
    end
  end
end
