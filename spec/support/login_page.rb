class LoginPage
  include Capybara::DSL

  def initialize
    @user = FactoryGirl.create(:user)
  end

  def visit_page
    visit('/users/sign_in')
    self
  end

  def fill_in_data(params = {})
    fill_in('Enter email', with: params.fetch(:email, @user.email))
    fill_in('Password', with: params.fetch(:password, @user.password))
    self
  end

  def submit
    click_on('Back to Store')
  end

  def log_in(user = @user)
    visit_page.fill_in_data(email: user.email, password: user.password).submit
  end
end
