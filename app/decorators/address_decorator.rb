class AddressDecorator
  attr_reader :model

  def initialize(model)
    @model = model
  end

  def full_name
    "#{model.first_name} #{model.last_name}"
  end

  def full_city
    "#{model.city} #{model.zip}"
  end

  def full_phone
    "Phone #{model.phone}"
  end
end
