class Delivery < ApplicationRecord
  has_many :orders
  validates :method, :days, :price, presence: true

  def to_s
    '#{method} #{days}'
  end
end
