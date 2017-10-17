class DeliveryFormBuilder
  def self.build_from_model(current_order)
    DeliveryForm.from_model(current_order.delivery || Delivery.new)
  end
end
