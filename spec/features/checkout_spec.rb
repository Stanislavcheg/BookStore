require 'rails_helper'
require_relative '../support/checkout_page'

feature 'order registration' do
  before do
    @user = FactoryGirl.create(:user_with_orders)
    @order = @user.orders.first
  end

  let(:checkout_page) { CheckoutPage.new(@user, @order) }

  scenario 'all entered order attributes are displayed at confirm step', js: true do
    checkout_page.visit_page.
    fill_in_address(:billing).
    fill_in_address(:shipping).submit.
    chose_delivery.submit.
    fill_in_payment.submit

    @order.reload
    expect(page).to have_content(@order.billing_address.address)
    expect(page).to have_content(@order.shipping_address.address)
    expect(page).to have_content(@order.credit_card.expires)
    expect(page).to have_content(@order.delivery.days)
    expect(page).to have_content(@order.positions.first.book.name)
  end

  scenario 'system registers user order after all steps are completed', js: true do
    checkout_page.visit_page.
    fill_in_address(:billing).
    fill_in_address(:shipping).submit.
    chose_delivery.submit.
    fill_in_payment.submit.submit

    expect(page).to have_content('Thank You for your Order!')
  end
end
