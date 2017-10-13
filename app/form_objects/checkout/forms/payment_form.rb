class PaymentForm < Rectify::Form
  mimic :credit_card
  attribute :number, String
  attribute :name, String
  attribute :expires, String
  attribute :cvv, String

  validates :number, :name, :expires, :cvv, presence: true
  validates :cvv, format: { with: /\A\d{3,4}\z/ }
  validates :number, format: { with: /\A\d{16}\z/ }
  validates :name, format: { with: /\A[a-zA-Z ]+\z/ }
  validates :expires, format: { with: /\A(0[1-9]|1[0-2])\/(\d{2})\z/ }

  def save
    return false if invalid?
    persist!
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
