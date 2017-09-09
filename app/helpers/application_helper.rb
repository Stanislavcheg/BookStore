module ApplicationHelper
  def billing_address
    BillingAddressForm.from_model(current_user.billing_address || BillingAddress.new)
  end

  def shipping_address
    ShippingAddressForm.from_model(current_user.shipping_address || ShippingAddress.new)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
