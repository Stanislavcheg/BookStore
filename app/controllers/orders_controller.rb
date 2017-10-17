class OrdersController < ApplicationController
  before_action :authenticate_user!

  def show
    @order = current_user.orders.find(params[:id])
  end

  def index
    @filter_title = params[:filter_title] || 'All'
    @orders = current_user.orders
    @orders = @orders.select {|order| order.order_status == params[:order_status] } if params[:order_status]
  end
end
