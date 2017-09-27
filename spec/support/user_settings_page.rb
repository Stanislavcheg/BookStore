class UserSettingsPage
  include Capybara::DSL
  include Warden::Test::Helpers
  include WaitForAjax

  attr_reader :user

  def initialize(user = nil)
    @user ||= FactoryGirl.create(:user)
    @address = FactoryGirl.create(:address)
    login_as(@user, scope: :user)
  end

  def visit_page
    visit('/users/edit')
    self
  end

  def fill_in_address(symb, params = {})
    within(".#{symb}") do
      fill_in('First Name', with: params.fetch(:first_name, @address.first_name))
      fill_in('Last Name', with: params.fetch(:last_name, @address.last_name))
      fill_in('Address', with: params.fetch(:address, @address.address))
      fill_in('City', with: params.fetch(:city, @address.city))
      fill_in('Zip', with: params.fetch(:zip, @address.zip))
      select(params.fetch(:country, 'Ukraine'), from: 'Country')
      fill_in('Phone', with: params.fetch(:phone, @address.phone))
    end
    self
  end

  def fill_in_email(email = 'example@mail.com')
    fill_in('email', with: email)
    self
  end

  def fill_in_new_password(new_password)
    fill_in('oldPassword', with: @user.password)
    fill_in('password', with: new_password)
    fill_in('confirmPassword', with: new_password)
    first('p').click
    wait_for_ajax
    self
  end

  def go_to_address_tab
    find('a.address').click
    self
  end

  def go_to_privacy_tab
    find('a.privacy').click
    self
  end

  def submit(subject)
    within ".#{subject}" do
      click_on 'Save'
    end
    self
  end

  def remove_account
    within '.remove_acc' do
      find('i.fa.fa-check').click
      wait_for_ajax
      click_on 'Please Remove My Account'
    end
    self
  end
end
