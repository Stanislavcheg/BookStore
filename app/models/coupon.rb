class Coupon < ApplicationRecord
  validates :code, :discount, presence: true
  validates_uniqueness_of :code
  has_many :orders

  def to_s
    "code: #{code}, discount: #{discount}"
  end
end
