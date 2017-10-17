require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }
  let(:book) { FactoryGirl.create(:book) }
  let(:valid_attrs) { FactoryGirl.attributes_for(:review, title: "anonymous", user_id: user.id, book_id: book.id) }
  let(:invalid_attrs) { FactoryGirl.attributes_for(:review, title: "", user_id: user.id, book_id: book.id) }

  describe "POST create" do
    describe 'valid' do
      it 'redirects to book url' do
        post :create, params: { review: valid_attrs }
        expect(response).to redirect_to(book_url valid_attrs[:book_id])
      end
      it 'creates new review in database' do
        expect {
          post :create, params: { review: valid_attrs }
        }.to change(Review, :count).by(1)
      end
    end

    context 'invalid' do
      it "renders book's template" do
        post :create, params: { review: invalid_attrs }
        expect(response).to render_template('books/show')
      end
      it "doesn't create new review in database" do
        expect {
          post :create, params: { review: invalid_attrs }
        }.not_to change(Review, :count)
      end
    end
  end
end
