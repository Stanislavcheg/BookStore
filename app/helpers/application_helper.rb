module ApplicationHelper
  def billing_address
    current_user.billing_address || BillingAddress.new
  end

  def shipping_address
    current_user.shipping_address || ShippingAddress.new
  end
end
