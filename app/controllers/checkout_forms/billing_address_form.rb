class BillingAddressForm < AddressForm
  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    order = context.order
    if order.billing_address
      order.billing_address.update_attributes(address_params)
    else
      billing_address = BillingAddress.new(address_params)
      billing_address.addressable_type = 'Order'
      billing_address.addressable_id = order.id
      billing_address.save
    end
  end
end
