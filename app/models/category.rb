class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :books

  def best_seller
    books.sort_by(&:sold_count).last
  end
end
