class CatalogPage
  include Capybara::DSL

  def initialize
    @books = FactoryGirl.create_list(:book, 5)
  end

  def visit_page
    visit('/books')
    self
  end

  def add_to_cart
    first(".thumb-hover-link.buy").click
    self
  end
end
