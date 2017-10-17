class CouponsController < ApplicationController
  def link_order
    unless current_order.coupon
      @coupon = Coupon.find_by(code: params[:code])
      if @coupon
        @coupon.orders << current_order
      else
        flash.now[:alert] = t('coupon.errors.no_code')
        @positions = current_order.positions
        return render 'carts/show'
      end
    end
    redirect_to cart_path
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount, :order_id)
  end
end
