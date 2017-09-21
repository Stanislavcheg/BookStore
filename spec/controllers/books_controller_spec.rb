require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  describe 'GET show' do
    let(:book) { FactoryGirl.create(:book) }

    it 'renders :show template' do
      get :show, params: { id: book }
      expect(response).to render_template(:show)
    end
    it 'assigns requested book to @book' do
      get :show, params: { id: book }
      expect(assigns(:book)).to eq(book)
    end
  end

  describe 'GET index' do
    let!(:books) { FactoryGirl.create_list(:book, 3) }
    let!(:category) { FactoryGirl.create(:category_with_books) }

    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end
    context "when category isn't chosen" do
      it 'assigns all books to template' do
        get :index
        expect(assigns(:books)).to match_array(books + category.books)
      end
    end
    context "when category is chosen" do
      it 'assigns books only of chosen category to template' do
        get :index, params: {category_id: category.id}
        expect(assigns(:books)).to match_array(category.books)
      end
    end
  end
end
