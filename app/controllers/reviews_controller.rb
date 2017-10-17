class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @book = Book.find(@review.book_id)
    @position = current_order.positions.new

    if @review.save
      flash[:notice] = t('review.notice.on_create')
      redirect_to book_path @book
    else
      render 'books/show', id: @review.book_id, objects: [@book, @review, @position]
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :description, :rating, :status, :book_id, :user_id)
  end
end
