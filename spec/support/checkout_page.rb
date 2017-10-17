class CheckoutPage
  require_relative '../support/session'
  include Capybara::DSL
  include Warden::Test::Helpers
  include Session

  def initialize(user, current_order)
    @address = FactoryGirl.create(:address)
    @credit_card = FactoryGirl.create(:credit_card)
    login_as(user, scope: :user)
    session order_id: current_order.id
    session prev_step_done: true
  end

  def visit_page
    visit('/checkout/address')
    self
  end

  def fill_in_address(symb, params = {})
    scope = case symb
            when :billing
              '.billing'
            when :shipping
              '.shipping'
            end
    within(scope) do
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

  def chose_delivery(id = nil)
    selector = id ? "##{id}" : '.radio-icon'
    first('span.radio-icon').click
    self
  end

  def fill_in_payment(params = {})
    fill_in('Card Number', with: params.fetch(:number, @credit_card.number))
    fill_in('Name on Card', with: params.fetch(:name, @credit_card.name))
    fill_in('MM / YY', with: params.fetch(:expires, @credit_card.expires))
    fill_in('CVV', with: params.fetch(:cvv, @credit_card.cvv))
    self
  end

  def submit
    find('.submit').click
    self
  end
end
