class Book < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  validates :name, :price, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true }
  validates :price, :year, numericality: { greater_than_or_equal_to: 0 }
  has_and_belongs_to_many :authors
  belongs_to :category
  has_many :positions

  def short_description
    description.truncate(100, separator: ' ')
  end

  def price_euro
    number_to_currency price, unit: '€'
  end
end
