class CreditCardDecorator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def masked_number
    last_digits = model.number.to_s.length <= 4 ? model.number : model.number.to_s.slice(-4..-1)
    "**** **** **** #{last_digits}"
  end
end
