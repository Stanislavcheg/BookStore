class DeliveryForm < Rectify::Form
  attribute :id, Integer
  validates :id, presence: true

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    order = context.order
    order.delivery_id = self.id
    order.save
  end
end
