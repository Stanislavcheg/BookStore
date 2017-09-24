require 'rails_helper'
require_relative '../support/signup_page'

feature 'sign up to the store' do
  let(:signup_page) { SignupPage.new }

  scenario 'sign up with valid data' do
    expect {
      signup_page.visit_page.fill_in_data.submit
    }.to change(User, :count).by(1)
    expect(page).to have_content('A message with a confirmation link has been sent to your email address')
  end

  scenario 'sign up with invalid data' do
    expect {
      signup_page.visit_page.fill_in_data(password: '').submit
    }.not_to change(User, :count)
    expect(page).to have_content('prohibited this user from being saved')
  end
end
