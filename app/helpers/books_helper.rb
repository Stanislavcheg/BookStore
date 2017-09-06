module BooksHelper
  def sortable(title, sort_by, page, category)
    link_to title, url(category, sort_by: sort_by, page: page, sort_title: title)
  end

  def url(category, options = {})
    if category
      category_books_path(category, options)
    else
      books_path(options)
    end
  end
end
