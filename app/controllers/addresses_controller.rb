class AddressesController < ApplicationController
  protected

  def process_form(form, address_identifier)
    if form.valid?
      yield
      redirect_to edit_user_registration_path
    else
      render 'devise/registrations/edit', locals: { address_identifier => form }
    end
  end

  def address_params(address)
    params.require(address).permit(:first_name, :last_name, :address, :city,
    :zip, :country, :phone)
  end
end
