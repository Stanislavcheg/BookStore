require 'rails_helper'

RSpec.describe "book_attachments/edit", type: :view do
  before(:each) do
    @book_attachment = assign(:book_attachment, BookAttachment.create!(
      :book => nil,
      :image => "MyString"
    ))
  end

  it "renders the edit book_attachment form" do
    render

    assert_select "form[action=?][method=?]", book_attachment_path(@book_attachment), "post" do

      assert_select "input[name=?]", "book_attachment[book_id]"

      assert_select "input[name=?]", "book_attachment[image]"
    end
  end
end
