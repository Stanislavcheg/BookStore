class DeliveryForm < Rectify::Form
  attribute :id, Integer
  validates :id, presence: true

  def save
    return false if invalid?
    persist!
  end

  private

  def persist!
    order = context.order
    order.delivery_id = self.id
    order.save
  end
end
