class BillingAddressesController < AddressesController
  def create
    @billing_address = BillingAddress.new(billing_address_params)
    current_user.billing_address = @billing_address
    save_address @billing_address, "Billing address"
  end

  def update
    @billing_address = current_user.billing_address
    update_address @billing_address,billing_address_params, "Billing address"
  end

  private

  def billing_address_params
    address_params :billing_address
  end
end
