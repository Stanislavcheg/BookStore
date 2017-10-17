require 'rails_helper'
require_relative '../support/user_settings_page'

feature 'user settings' do
  before(:each) do
    @settings_page = UserSettingsPage.new
    @user = @settings_page.user
  end

  context 'address change' do
    scenario 'user can update billing address' do
      @settings_page.visit_page.fill_in_address(:billing, address: 'street 21').submit(:billing)
      @user.reload
      expect(@user.billing_address.address).to eq('street 21')
    end
    scenario 'user can update shipping address' do
      @settings_page.visit_page.fill_in_address(:shipping, address: 'street 21').submit(:shipping)
      @user.reload
      expect(@user.shipping_address.address).to eq('street 21')
    end
  end

  scenario 'user update email', js: true do
    @settings_page.visit_page.go_to_privacy_tab.fill_in_email('example@mail.com').submit(:email)
    @user.reload
    expect(@user.email).to eq('example@mail.com')
  end

  scenario 'user can update password', js: true do
    @settings_page.visit_page.go_to_privacy_tab.fill_in_new_password('12345678s').submit(:password)
    expect(page).to have_content("Your account has been updated successfully.")
  end

  scenario 'user can delete account', js:true do
    @settings_page.visit_page.go_to_privacy_tab.remove_account
    expect(User.all.include? @user).to be_falsey
  end
end
