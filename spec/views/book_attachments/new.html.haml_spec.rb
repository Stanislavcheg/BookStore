require 'rails_helper'

RSpec.describe "book_attachments/new", type: :view do
  before(:each) do
    assign(:book_attachment, BookAttachment.new(
      :book => nil,
      :image => "MyString"
    ))
  end

  it "renders new book_attachment form" do
    render

    assert_select "form[action=?][method=?]", book_attachments_path, "post" do

      assert_select "input[name=?]", "book_attachment[book_id]"

      assert_select "input[name=?]", "book_attachment[image]"
    end
  end
end
