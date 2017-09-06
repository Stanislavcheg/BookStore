class CouponsController < ApplicationController

  def link_order
    unless current_order.coupon
      @coupon = Coupon.find_by(code: params[:code])
      @coupon.orders << current_order
    end
    redirect_to cart_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount, :order_id)
  end
end
