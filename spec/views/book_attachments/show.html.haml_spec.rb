require 'rails_helper'

RSpec.describe "book_attachments/show", type: :view do
  before(:each) do
    @book_attachment = assign(:book_attachment, BookAttachment.create!(
      :book => nil,
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Image/)
  end
end
