require 'rails_helper'

RSpec.describe CouponsController, type: :controller do
  let(:user) { FactoryGirl.create(:user_with_orders) }

  before do
    sign_in user
    session[:order_id] = subject.current_user.orders.first.id
  end

  let(:order) { Order.find(session[:order_id]) }
  let(:coupon) { FactoryGirl.create(:coupon) }

  describe 'PUT link_order' do
    describe 'valid' do
      it 'links coupon to the order' do
        put :link_order, params: { code: coupon.code }
        expect(order.coupon).to eq(coupon)
      end
      it 'redirects to user cart' do
        put :link_order, params: { code: coupon.code }
        expect(response).to redirect_to(cart_url)
      end
    end
    describe 'invalid' do
      it 'renders user card template' do
        put :link_order, params: { code: "" }
        expect(response).to render_template('carts/show')
      end
      it "doesn't link coupon to order" do
        put :link_order, params: { code: "" }
        expect(order.coupon).to be_nil
      end
    end
  end
end
