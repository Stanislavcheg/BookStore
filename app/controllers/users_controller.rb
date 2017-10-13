class UsersController < ApplicationController
  def update_email
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to edit_user_registration_path, notice: t('user.notice.email_changed')
    else
      render 'devise/registrations/edit', error: t('user.errors.invalid_email')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
