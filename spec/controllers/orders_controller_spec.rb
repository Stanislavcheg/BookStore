require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'unauthorized user' do
    describe 'GET :index' do
      it 'redirects user to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_url)
      end
    end
    describe 'GET :show' do
      let(:order) { FactoryGirl.create(:order) }

      it 'redirects user to login page' do
        get :show, params: { id: order.id }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end
  describe 'logged user' do
    let(:user) { FactoryGirl.create(:user_with_orders) }

    before do
      sign_in user
    end

    describe 'GET :index' do
      it 'renders :index template' do
        get :index
        expect(response).to render_template(:index)
      end

      context "when user has orders" do
        it 'assigns all user orders to the template' do
          get :index
          expect(assigns(:orders)).to match_array(user.orders)
        end
        context 'when filter is chosen' do
          it 'assigns only filtered orders to the template' do
            order = subject.current_user.orders.first
            order.order_status = 'in_delivery'
            order.save
            get :index, params: { order_status: 'in_delivery' }
            expect(assigns(:orders).count).to eq(1)
            expect(assigns(:orders).first).to eq(order)
          end
        end
      end
    end

    describe 'GET :show' do
      it 'renders :show template' do
        get :show, params: { id: user.orders.first }
        expect(response).to render_template(:show)
      end
      it 'assigns all user orders to the template' do
        get :show, params: { id: user.orders.first }
        expect(assigns(:order)).to eq(user.orders.first)
      end
    end
  end
end
