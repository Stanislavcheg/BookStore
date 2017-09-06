class AddressesController < ApplicationController
  protected

  def save_address(address, title)
    route_address(address.save, title)
  end

  def update_address(address, address_params, title)
    route_address(address.update(address_params), title)
  end

  def route_address(condition, title)
    if condition
      redirect_to root_path, notice: "#{title} successfully changed"
    else
      render edit_user_registration_path
    end
  end

  def address_params(address)
    params.require(address).permit(:first_name, :last_name, :address, :city,
    :zip, :country, :phone)
  end
end
