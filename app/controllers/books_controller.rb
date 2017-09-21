class BooksController < ApplicationController
  before_action :set_position, only: [:show, :index]

  def show
    @book = Book.find(params[:id])
    if current_user
      @review = Review.new(book_id: @book.id, user_id: current_user.id, title: current_user.name)
    end
  end

  def index
    @category = Category.find_by(id: params[:category_id])
    @all_books = @category ? @category.books : Book.all
    @page_number = params[:page] || 1
    @sort_title = params[:sort_title] || "Newest first"
    @sort_by = params[:sort_by] || "created_at DESC"
    @books = @all_books.order(@sort_by).limit(Integer(@page_number)*6)
    @more_books_left = @all_books.count > @books.count
  end

  private

  def set_position
    @position = current_order.positions.new
  end

  def book_params
    params.require(:book).permit(:name, :authors, :price, :quantity,
      :description, :year, :dimensions, :materials, :category_id)
  end
end
