class HomePage
  include Capybara::DSL

  def initialize
    @books = FactoryGirl.create_list(:book, 5)
  end

  def visit_page
    visit('/')
    self
  end

  def add_to_cart(symb)
    case symb
    when :best_seller
      first(".thumb-hover-link.buy").click
    when :latest_book
      first("#slider input.btn").click
    end
    self
  end

  def click_get_started
    click_on('Get Started')
  end
end
