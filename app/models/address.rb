class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  def decorate
    @decorator ||= AddressDecorator.new self
  end
end
