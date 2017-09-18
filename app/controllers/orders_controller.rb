class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @filter_title = params[:order_status] || "All"
    @orders = current_user.orders
    @orders = @orders.joins(:order_status).where(order_statuses: { name: params[:order_status] }) if params[:order_status]
    redirect_to root_path, notice: 'You have no orders yet' if @orders.nil?
  end
end
