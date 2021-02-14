require 'rails_helper'

RSpec.describe "attachments/index", type: :view do
  before(:each) do
    assign(:attachments, [
      Attachment.create!(
        caption: "Caption"
      ),
      Attachment.create!(
        caption: "Caption"
      )
    ])
  end

  it "renders a list of attachments" do
    render
    assert_select "tr>td", text: "Caption".to_s, count: 2
  end
end
