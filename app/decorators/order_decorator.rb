class OrderDecorator
  include ActionView::Helpers::NumberHelper
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def name
    "Order: #{model.order_number} #{model.order_status}"
  end

  def available_statuses
    @exclude_list = [0]
    @exclude_list << 3 unless model.order_status == 2
    available_status_codes = Order.order_statuses.values - @exclude_list
    available_status_codes.map { |code|  Order.order_statuses.key(code) }
  end

  def price_euro
    number_to_currency model.price, unit: '€'
  end
end
