class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_position, only: [:show, :index]
  before_action :set_category, only: :index
  before_action :set_all_books, only: :index

  def show
    @review = Review.new(book_id: @book.id, user_id: current_user.id, title: current_user.name)
  end

  def index
    @page_number = params[:page] || 1
    @sort_title = params[:sort_title] || "Newest first"
    @sort_by = params[:sort_by] || "created_at DESC"
    @books = @all_books.order(@sort_by).limit(Integer(@page_number)*3)
    @more_books_left = @all_books.count > @books.count
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def set_position
    @position = current_order.positions.new
  end

  def set_category
    @category = Category.find_by(id: params[:category_id])
  end

  def set_all_books
    @all_books = @category ? @category.books : Book.all
  end

  def book_params
    params.require(:book).permit(:name, :authors, :price, :quantity,
    :description, :year, :dimensions, :materials, :category_id)
  end
end
