class ShippingAddressesController < AddressesController
  def create
    shipping_address = ShippingAddress.new(shipping_address_params)
    address_form = ShippingAddressForm.from_model(shipping_address)

    process_form address_form, :shipping_address do
      shipping_address.save
      current_user.shipping_address = shipping_address
    end
  end

  def update
    shipping_address = current_user.shipping_address
    address_form = ShippingAddressForm.from_params(shipping_address_params)

    process_form address_form, :shipping_address do
      shipping_address.update shipping_address_params
    end
  end

  private

  def shipping_address_params
    address_params :shipping_address
  end
end
