class UsersController < ApplicationController
  def update_email
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to edit_user_registration_path, notice: "Email was successfully changed"
    else
      render 'devise/registrations/edit', error: "Email is not valid"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
