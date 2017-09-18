class AddressForm < Rectify::Form
  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, String
  attribute :country, String
  attribute :phone, String

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z]+\z/ }
  validates :city, :country, format: { with: /\A[a-zA-Z ]+\z/ }
  validates :address, format: { with: /\A[a-zA-Z\d'\-\s]+\z/ }
  validates :zip, format: { with: /\A[\d\-]+\z/ }
  validates :phone, format: { with: /\A\+\d+\z/ }
  validates_length_of :first_name, :last_name, :address, :city, :country, maximum: 50
  validates_length_of :phone, maximum: 15
  validates_length_of :zip, maximum: 10

  protected

  def address_params
    { first_name: first_name, last_name: last_name, address: address, city: city,
      zip: zip, country: country, phone: phone }
  end
end
