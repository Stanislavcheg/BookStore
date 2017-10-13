class BookPresenter
  def initialize(params)
    @params = params
  end

  def category
    Category.find_by(id: @params[:category_id])
  end

  def categories
    Category.all
  end

  def page_number
    @params[:page] || 1
  end

  def category_title
    category ? category.name : "All"
  end

  def sort_title
    @params[:sort_title] || I18n.t('book.default_sort.title')
  end

  def sort_by
    @params[:sort_by] || "#{I18n.t('book.default_sort.criteria')} DESC"
  end

  def books
    all_books.order(sort_by).limit(Integer(page_number)*6)
  end

  def more_books_left
    all_books.count > books.count
  end

  private

  def all_books
    category ? category.books : Book.all
  end
end
