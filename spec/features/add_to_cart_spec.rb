require 'rails_helper'
require_relative '../support/home_page'
require_relative '../support/catalog_page'
require_relative '../support/book_page'

feature 'add to the user cart' do
  let(:home_page) { HomePage.new }
  let(:catalog_page) { CatalogPage.new }
  let(:book_page) { BookPage.new }

  context 'from the home page' do
    scenario 'add a best seller to the cart' do
      home_page.visit_page.add_to_cart(:best_seller)
      expect(first('span.shop-quantity').text).to eq('1')
    end
    scenario 'add a latest book to the cart' do
      home_page.visit_page.add_to_cart(:latest_book)
      expect(first('span.shop-quantity').text).to eq('1')
    end
  end

  context 'from catalog' do
    scenario 'add a book to the cart' do
      catalog_page.visit_page.add_to_cart
      expect(first('span.shop-quantity').text).to eq('1')
    end
  end

  context 'from book page' do
    scenario 'add book to the cart', js: true do
      book_page.visit_page.add_to_cart
      expect(first('span.shop-quantity').text).to eq('1')
    end
  end
end
