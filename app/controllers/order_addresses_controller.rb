class OrderAddressesController < ApplicationController
  def new
    @billing_address = current_user.billing_address.clone || BillingAddress.new
    @shipping_address = current_user.shipping_address.clone || ShippingAddress.new
  end

  def create
  @billing_address = BillingAddress.new(billing_address_params)
  @shipping_address = ShippingAddress.new(shipping_address_params)
  current_order.billing_address = @billing_address
  current_order.shipping_address = @shipping_address
    if current_order.save
      redirect_to
    else
      render 'new'
    end
  end

  private

  def billing_address_params
    params.require(:billing_address).permit(:name, :author, :price, :quantity,
    :description, :year, :dimensions, :materials, :category_id)
  end

  def shipping_address_params
    params.require(:shipping_address).permit(:name, :author, :price, :quantity,
    :description, :year, :dimensions, :materials, :category_id)
  end

end
