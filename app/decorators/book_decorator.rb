class BookDecorator
  include ActionView::Helpers::NumberHelper
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def price_euro
    number_to_currency model.price, unit: '€'
  end

  def authors_formated
    model.authors.join(', ')
  end

  def dimensions
    "H:#{model.height.round(1)}\" x W:#{model.width.round(1)}\" x D:#{model.depth.round(1)}\""
  end
end
