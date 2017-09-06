class PositionsController < ApplicationController
  before_action :set_order
  before_action :check_same_position, only: [:create]

  def create
    @position = @order.positions.new(position_params)
    @order.save!
    session[:order_id] = @order.id
    redirect_to request.referrer
  end

  def update
    @position = @order.positions.find(params[:id])
    @position.update_attributes(position_params)
    @positions = @order.positions
    redirect_to cart_path
  end

  def destroy
    @position = @order.positions.find(params[:id])
    @position.destroy
    @positions = @order.positions
    redirect_to cart_path
  end

  private

  def set_order
    @order = current_order
  end

  def position_params
    params.require(:position).permit(:quantity, :book_id)
  end

  def check_same_position
    @same_position = current_order.positions.find do |pos|
      pos.book_id == Integer(params[:position][:book_id])
    end
    if @same_position
      @same_position.quantity += 1
      @same_position.save
      redirect_to request.referrer
    end
  end
end
