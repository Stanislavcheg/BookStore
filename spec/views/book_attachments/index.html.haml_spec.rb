require 'rails_helper'

RSpec.describe "book_attachments/index", type: :view do
  before(:each) do
    assign(:book_attachments, [
      BookAttachment.create!(
        :book => nil,
        :image => "Image"
      ),
      BookAttachment.create!(
        :book => nil,
        :image => "Image"
      )
    ])
  end

  it "renders a list of book_attachments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
