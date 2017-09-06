class ShippingAddressesController < AddressesController
  def create
    @shipping_address = ShippingAddress.new(shipping_address_params)
    current_user.shipping_address = @shipping_address
    save_address @shipping_address, "Shipping address"
  end

  def update
    @shipping_address = current_user.shipping_address
    update_address @shipping_address,shipping_address_params, "Shipping address"
  end

  private

  def shipping_address_params
    address_params :shipping_address
  end
end
