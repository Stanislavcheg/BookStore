class BooksController < ApplicationController
  before_action :set_position, only: %i[show index]

  def show
    @book = Book.find(params[:id])
    return unless current_user
    @review = Review.new(book_id: @book.id,
                         user_id: current_user.id,
                           title: current_user.name)
  end

  def index
    @book_presenter = BookPresenter.new(params)
  end

  private

  def set_position
    @position = current_order.positions.new
  end

  def book_params
    params.require(:book).permit(:name,
                                 :authors,
                                 :price,
                                 :quantity,
                                 :description,
                                 :year,
                                 :dimensions,
                                 :materials,
                                 :category_id)
  end
end
