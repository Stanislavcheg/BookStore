require 'rails_helper'
require_relative '../support/book_page'

feature 'write a review' do
  let(:book_page) { BookPage.new }
  let(:user) { FactoryGirl.create(:user) }

  scenario 'logged user can write a review' do
    book_page.login_as(user, scope: :user)
    book_page.visit_page.fill_in_new_review.submit_review
    expect(page).to have_content("Thanks for Review. It will be published as soon as Admin will approve it")
  end
end
