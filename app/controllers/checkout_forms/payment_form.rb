class PaymentForm < Rectify::Form
  mimic :credit_card
  attribute :number, String
  attribute :name, String
  attribute :expires, String
  attribute :cvv, String

  validates :number, :name, :expires, :cvv, presence: true

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def credit_card_params
    { number: number, name: name, expires: expires, cvv: cvv }
  end

  def persist!
    order = context.order
    if order.credit_card
      order.credit_card.update_attributes(credit_card_params)
    else
      credit_card = CreditCard.new(credit_card_params)
      credit_card.order_id = order.id
      credit_card.save
    end
  end
end
