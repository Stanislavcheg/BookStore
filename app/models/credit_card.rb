class CreditCard < ApplicationRecord
  belongs_to :order

  def decorate
    @decorator ||= CreditCardDecorator.new self
  end
end
