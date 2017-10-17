class Author < ApplicationRecord
  has_and_belongs_to_many :books
  validates :first_name, :last_name, presence: true
  validates_uniqueness_of :first_name, scope: :last_name

  def to_s
    "#{first_name} #{last_name}"
  end
end
