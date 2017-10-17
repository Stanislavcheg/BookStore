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
    available_status_codes.map {|code| Order.order_statuses.key(code) }
  end

  def total_euro
    number_to_currency model.total, unit: '€'
  end

  def subtotal_euro
    number_to_currency model.subtotal, unit: '€'
  end

  def discount_euro
    number_to_currency model.discount, unit: '€'
  end

  def updated_at_formated
    model.updated_at.strftime('%F')
  end
end
