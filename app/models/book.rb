class Book < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  validates :name, :price, :description, presence: true
  validates :height, :width, :depth, :price, :year, numericality: { greater_than: 0 }
  has_and_belongs_to_many :authors
  belongs_to :category
  has_many :positions
  has_many :reviews

  mount_uploaders :images, ImageUploader

  def short_description
    description.truncate(100, separator: ' ')
  end

  def price_euro
    number_to_currency price, unit: '€'
  end

  def sold_count
    positions.inject(0){ |sum, position| sum + position.quantity }
  end

  def authors_formated
    authors.join(", ")
  end

  def dimensions
    "H:#{height.round(1)}\" x W:#{width.round(1)}\" x D:#{depth.round(1)}\""
  end
end
