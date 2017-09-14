class Order < ApplicationRecord
  before_validation :set_order_status
  before_save :update_subtotal, :update_total
  before_create :set_order_number
  belongs_to :order_status
  belongs_to :coupon, optional: true
  belongs_to :user, optional: true
  belongs_to :delivery, optional: true
  has_many :positions, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  scope :in_progress, -> { joins(:order_status).where('order_statuses.name IN (?)',
  ['In Progress', 'Waiting for processing', 'In Delivery']) }
  scope :delivered, -> { joins(:order_status).where('order_statuses.name = ?', 'Delivered') }
  scope :canceled, -> { joins(:order_status).where('order_statuses.name = ?', 'Canceled') }

  def includes_book?(book)
    positions.map(&:book).include?(book)
  end

  def name
    "Order: #{order_number} #{order_status}"
  end

  def subtotal
    positions.collect { |pos| pos.valid? ? (pos.quantity * pos.unit_price) : 0 }.sum
  end

  def discount
    coupon.try(:discount).to_f * subtotal || 0
  end

  def total
    self[:total] = subtotal - discount + self.delivery.try(:price).to_f
  end

private

  def set_order_status
    self[:order_status_id] ||= 1
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
