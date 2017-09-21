require 'rails_helper'

RSpec.describe PositionsController, type: :controller do
  let(:order) { FactoryGirl.create(:order_with_positions) }

  before do
    session[:order_id] = order.id
  end

  let(:position) { Order.find(session[:order_id]).positions.first }
  let(:book) { FactoryGirl.create(:book) }
  let(:attrs) { FactoryGirl.attributes_for(:position, book_id: book.id) }

  describe "POST :create" do
    it 'returns http success' do
      post :create, params: { position: attrs }
      expect(response).to have_http_status(302)
    end
    it 'creates new position in database' do
      expect {
        post :create, params: { position: attrs }
      }.to change(Position, :count).by(1)
    end
  end

  describe "PUT :update" do
    it 'redirects to user cart' do
      put :update, params: { id: position.id, position: attrs }
      expect(response).to redirect_to(cart_url)
    end
    it 'updates position in database' do
      put :update, params: { id: position.id, position: attrs }
      position.reload
      expect(position.quantity).to eq(attrs[:quantity])
    end
  end

  describe "DELETE :destroy" do
    it 'redirects to user cart' do
      delete :destroy, params: { id: position.id }
      expect(response).to redirect_to(cart_url)
    end
    it 'deletes position from database' do
      delete :destroy, params: { id: position.id }
      expect(Position.exists?(position.id)).to be_falsey
    end
  end
end
