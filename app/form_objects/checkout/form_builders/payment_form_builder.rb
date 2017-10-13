class PaymentFormBuilder
  def self.build_from_model(current_order)
    PaymentForm.from_model(current_order.credit_card || CreditCard.new)
  end
end
