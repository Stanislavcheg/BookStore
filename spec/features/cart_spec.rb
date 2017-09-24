require 'rails_helper'
require_relative '../support/cart_page'

feature 'cart' do
  let(:cart_page) { CartPage.new }
  let(:cart_page_empty) { CartPage.new(with_positions: false) }
  let(:cart_page_unlogged) { CartPage.new(login: false, with_positions: true) }

  context 'empty cart' do
    scenario 'system displays appropriate message to user' do
      cart_page_empty.visit_page
      expect(page).to have_content('There are no items in your shopping cart')
    end
  end

  context 'cart with positions' do
    context 'position quantity change' do
      before(:each) do
        @cart_page = cart_page
        @position = cart_page.positions.first
        @position.update_attributes(quantity: 5)
        @old_quantity = @position.quantity
      end
      scenario 'user can add position quantity', js: true do
        @cart_page.visit_page.add_position_quantity(@position.id)
        @position.reload
        expect(@position.quantity).to eq(@old_quantity + 1)
      end
      scenario 'user can reduce position quantity', js: true do
        @cart_page.visit_page.reduce_position_quantity(@position.id)
        @position.reload
        expect(@position.quantity).to eq(@old_quantity - 1)
      end
      scenario 'user can set position quantity manualy', js: true do
        @cart_page.visit_page.fill_in_position_quantity(@position.id, 10)
        @position.reload
        expect(@position.quantity).to eq(10)
      end
    end
    scenario 'user can remove position', js: true do
      position = cart_page.positions.first
      expect {
        cart_page.visit_page.remove_position(position.id)
      }.to change(Position, :count).by(-1)
    end
    scenario 'user can apply coupon', js: true do
      order = cart_page.order
      cart_page.visit_page.fill_in_coupon.submit_coupon
      order.reload
      expect(order.coupon).not_to be_nil
    end
    context 'authorized user' do
      scenario 'user goes to checkout when clicks checkout button' do
        cart_page.visit_page.submit
        expect(page).to have_current_path(/checkout\/address/)
      end
    end
    context 'unauthorized user' do
      scenario 'user goes to login page when clicks checkout button' do
        cart_page_unlogged.visit_page.submit
        expect(page).to have_current_path(new_user_session_path)
      end
    end
  end
end
