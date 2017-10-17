require 'rails_helper'
require_relative '../support/login_page'

feature 'log in to the store' do
  let(:login_page) { LoginPage.new }

  scenario 'log in with valid data' do
    login_page.visit_page.fill_in_data.submit
    expect(page).to have_content('Signed in successfully')
  end

  scenario 'log in with invalid data' do
    login_page.visit_page.fill_in_data(email: 'fff').submit
    expect(page).to have_content('Invalid Email or password')
  end
end
