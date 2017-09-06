class AddressForm < Rectify::Form
  attribute :first_name, String
  attribute :last_name,  String
  attribute :address, String
  attribute :city,  String
  attribute :zip, String
  attribute :country,  String
  attribute :phone, String

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, presence: true
  validates_length_of :first_name, :last_name, :address, :city, :country, maximum: 50
  validates :first_name, :last_name, :city, format: { with: /[A-Za-z]/ }
  validates_length_of :phone, maximum: 15
  validates_length_of :zip, maximum: 10

  protected

  def address_params
    {first_name: first_name, last_name: last_name, address: address, city: city,
      zip: zip, country: country, phone: phone}
  end
end
