class UsersController < ApplicationController
  def update_email
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_path, notice: "Email was successfully changed"
    else
      render edit_user_registration_path, error: "Something went wrong"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :address, :email)
  end
end
