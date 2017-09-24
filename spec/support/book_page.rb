class BookPage
  include Capybara::DSL
  include Warden::Test::Helpers

  def initialize
    @book = FactoryGirl.create(:book)
  end

  def visit_page
    visit("/books/#{@book.id}")
    self
  end

  def add_quantity
    find('i.fa-plus').click
    self
  end

  def reduce_quantity
    find('i.fa-minus').click
    self
  end

  def add_to_cart
    first("input.buy").click
    self
  end

  def fill_in_new_review(params = {})
    fill_in('Full Name', with: params.fetch(:title, "anonymous"))
    select(params.fetch(:rating, '5'), from: 'Rating')
    fill_in('Description', with: params.fetch(:description, "Review text"))
    self
  end

  def submit_review
    find('.review_submit').click
    self
  end
end
