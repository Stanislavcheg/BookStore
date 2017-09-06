class UpdateOrder < Rectify::Command
  def initialize(form, property_name)
    @form = form
    @order = order
    @property_name = property_name
    @property_value = @form.new_model_instance
  end

  def call
    return broadcast(:invalid) if @form.invalid?

    transaction do
      set_property
      order.save
    end

    broadcast(:ok, order)
  end

  private

  def set_property
    order.send("#{@property_name.to_s}=", @property_value)
  end
end
