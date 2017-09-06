class Position < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :book_present
  validate :order_present

  before_save :finalize

  def unit_price
    if persisted?
      self[:unit_price]
    else
      book.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def book_present
    return unless book.nil?
    errors.add(:book, "is not valid or is not active.")
  end

  def order_present
    return unless order.nil?
    errors.add(:order, "is not a valid order.")
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
