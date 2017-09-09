class BillingAddressesController < AddressesController
  def create
    billing_address = BillingAddress.new(billing_address_params)
    address_form = BillingAddressForm.from_model(billing_address)

    process_form address_form, :billing_address do
      billing_address.save
      current_user.billing_address = billing_address
    end
  end

  def update
    billing_address = current_user.billing_address
    address_form = BillingAddressForm.from_params(billing_address_params)

    process_form address_form, :billing_address do
      billing_address.update billing_address_params
    end
  end

  private

  def billing_address_params
    address_params :billing_address
  end
end
