class Coupon < ApplicationRecord
  validates :code, :discount, presence: true
  validates :code, uniqueness: true
  has_many :orders

  def to_s
    "code: #{code}, discount: #{discount}"
  end
end
