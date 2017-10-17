class Book < ApplicationRecord

  validates :name, :price, :description, presence: true
  validates :height, :width, :depth, :price, :year, numericality: {greater_than_or_equal_to: 0.01}
  has_and_belongs_to_many :authors
  belongs_to :category
  has_many :positions
  has_many :reviews

  mount_uploaders :images, ImageUploader

  scope :latest_books, -> { order(created_at: :desc).limit(3) }

  SHORT_DESCRIPTION_LENGHT = 100

  def short_description
    description.truncate(SHORT_DESCRIPTION_LENGHT, separator: ' ')
  end

  def sold_count
    positions.inject(0) {|sum, position| sum + position.quantity }
  end

  def decorate
    @decorator ||= BookDecorator.new self
  end
end
