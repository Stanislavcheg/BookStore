class Address < ApplicationRecord
  validates :first_name, :last_name, presence: true
  belongs_to :addressable, polymorphic: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_city
    "#{city} #{zip}"
  end

  def full_phone
    "Phone #{phone}"
  end
end
