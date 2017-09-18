class CreditCard < ApplicationRecord
  validates :number, :name, :expires, :cvv, presence: true
  validates :cvv, format: { with: /\A\d{3,4}\z/ }
  validates :number, format: { with: /\A\d{16}\z/ }
  validates :name, format: { with: /\A[a-zA-Z ]+\z/ }
  validates :expires, format: { with: /\A(0[1-9]|1[0-2])\/(\d{2})\z/ }

  belongs_to :order

  def masked_number
    last_digits = number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
    "**** **** **** #{last_digits}"
  end
end
