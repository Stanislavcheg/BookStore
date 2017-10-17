class HomeController < ApplicationController
  def index
    @latest_books = Book.latest_books
  end
end
