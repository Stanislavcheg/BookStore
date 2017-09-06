class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = current_user.orders
    redirect_to root_path, notice: 'You have no orders yet' if @orders.nil?
  end
end
