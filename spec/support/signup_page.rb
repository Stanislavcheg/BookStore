class SignupPage
  include Capybara::DSL

  def initialize
    @user_attrs = FactoryGirl.attributes_for(:user)
  end

  def visit_page
    visit('/users/sign_up')
    self
  end

  def fill_in_data(params = {})
    fill_in('Enter email', with: params.fetch(:email, @user_attrs[:email]))
    fill_in('Password', with: params.fetch(:password, @user_attrs[:password]))
    fill_in('Confirm Password', with: params.fetch(:password_confirmation, @user_attrs[:password_confirmation]))
    self
  end

  def submit
    click_on('Sign up')
  end
end
