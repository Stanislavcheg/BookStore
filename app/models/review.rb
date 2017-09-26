class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :title, :rating, :description, presence: true
  validates :rating, inclusion: { in: 1..5 }
  validates :title, length: { maximum: 80 }
  validates :description, length: { maximum: 500 }
  validates :description, :title, format: { with: /\A[a-zA-Z\d\s!#$%&'*+\/=?^_`{|}~.,-]+\z/ }

  scope :unprocessed, -> { where('status = ?', 'Unprocessed') }
  scope :processed, -> { where('status IN (?)', ['Approved', 'Rejected']) }
  scope :approved, -> { where('status = ?', 'Approved') }

  def date
    created_at.strftime("%m/%d/%y")
  end

  def verified?
    user.orders.any? do |order|
      order.includes_book?(book) && order.order_status == 'delivered'
    end
  end
end
