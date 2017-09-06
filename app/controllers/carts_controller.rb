class CartsController < ApplicationController
def show
    @positions = current_order.positions
  end
end
