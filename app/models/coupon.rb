class Coupon < ApplicationRecord
  has_many :orders

  def to_s
    "code: #{code}, discount: #{discount}"
  end
end
