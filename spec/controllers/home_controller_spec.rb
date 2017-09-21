require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    let!(:books) { FactoryGirl.create_list(:book, 5) }

    it 'renders :index template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'assigns 3 latest books to the template' do
      get :index
      expect(assigns(:latest_books)).to match_array(books.sort{ |book| book.created_at }[0..2])
    end
  end
end
