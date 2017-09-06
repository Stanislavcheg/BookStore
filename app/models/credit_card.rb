class CreditCard < ApplicationRecord
  belongs_to :order

  def masked_number
    last_digits = number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
    "**** **** **** #{last_digits}"
  end
end
