class CartPage
  require_relative '../support/session'
  require_relative '../support/wait_for_ajax'
  include Capybara::DSL
  include Warden::Test::Helpers
  include Session
  include WaitForAjax

  attr_reader :positions, :order

  def initialize(params = { login: true, with_positions: true, user: nil, current_order: nil })
    @user = params[:user] || FactoryGirl.create(:user)
    @order = params[:current_order] || FactoryGirl.create(:order_with_positions)

    if params[:with_positions] == true
      @order = params[:current_order] || FactoryGirl.create(:order_with_positions)
      session order_id: @order.id
      @positions = @order.positions
    end
    if params[:login] == true
      login_as(@user, scope: :user)
      @user.orders << @order
    end
  end

  def visit_page
    visit("/cart")
    self
  end

  def add_position_quantity(position_id = @positions.first.id)
    within("#pos#{position_id}") do
      sleep 0.3
      find('i.fa-plus').click
      wait_for_ajax
    end
    self
  end

  def reduce_position_quantity(position_id = @positions.first.id)
    within("#pos#{position_id}") do
      sleep 0.3
      find('i.fa-minus').click
      wait_for_ajax
    end
    self
  end

  def fill_in_position_quantity(position_id, quantity)
    within("#pos#{position_id}") do
      sleep 0.3
      find("#quantity_#{position_id}").set quantity
      first("span").click
      wait_for_ajax
    end
    self
  end

  def remove_position(position_id = @positions.first.id)
    within("#pos#{position_id}") do
      sleep 0.3
      find('span.remove').click
      wait_for_ajax
    end
    self
  end

  def fill_in_coupon(coupon_code = 'book_store')
    sleep 0.3
    find("#update_cart_text").set coupon_code
    first("#update_cart_lbl").click
    wait_for_ajax
    self
  end

  def submit_coupon
    find("#update_cart_btn").click
    self
  end

  def submit
    sleep 0.3
    click_on('Checkout')
  end
end
