module ShippingAddressesHelper
  def shipping_address
    current_user.shipping_address || ShippingAddress.new
  end

  def shipping_address_method
    if shipping_address.persisted?
      :put
    else
      :post
    end
  end
end
