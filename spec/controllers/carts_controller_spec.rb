require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET show' do
    let(:order) { FactoryGirl.create(:order_with_positions) }
    before do
      session[:order_id] = order.id
    end

    it 'renders :show template' do
      get :show
      expect(response).to render_template(:show)
    end
    it 'assigns requested positions to the template' do
      get :show
      expect(assigns(:positions)).to match_array(order.positions)
    end
  end
end
