class Author < ApplicationRecord
  has_and_belongs_to_many :books

  def to_s
    "#{first_name} #{last_name}"
  end
end
