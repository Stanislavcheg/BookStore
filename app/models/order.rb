class Order < ApplicationRecord
  before_validation :set_order_status, :decorate
  before_save :update_subtotal, :update_total
  before_create :set_order_number
  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_many :positions, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  enum order_status: { in_progress: 0, in_queue: 1, in_delivery: 2, delivered: 3, canceled: 4 }

  scope :in_progress, -> { where(order_status: [:in_progress, :in_queue, :in_delivery]) }
  scope :delivered, -> { where(order_status: :delivered) }
  scope :canceled, -> { where(order_status: :canceled) }

  def includes_book?(book)
    positions.map(&:book).include?(book)
  end

  def decorate
    @decorator ||= OrderDecorator.new self
  end

  def subtotal
    positions.collect { |pos| pos.valid? ? pos.total_price : 0 }.sum
  end

  def discount
    coupon.try(:discount).to_f * subtotal || 0
  end

  def total
    subtotal - discount + delivery.try(:price).to_f
  end

private

  def set_order_status
    self.order_status ||= 0
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def set_order_number
    self[:order_number] = generate_order_number
  end

  def generate_order_number
    'R' + Array.new(8) { rand 0..9 }.join
  end

  def update_total
    self[:total] = total
  end
end
