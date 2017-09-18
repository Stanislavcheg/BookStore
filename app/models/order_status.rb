class OrderStatus < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :orders

  def available_statuses
    @exclude_list = ['In Progress', 'Waiting for processing']
    @exclude_list << 'Delivered' unless name == 'In Delivery'
    OrderStatus.where.not(name: @exclude_list)
  end
end
