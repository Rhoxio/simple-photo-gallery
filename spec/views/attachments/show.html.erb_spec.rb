require 'rails_helper'

RSpec.describe "attachments/show", type: :view do
  before(:each) do
    @attachment = assign(:attachment, Attachment.create!(
      caption: "Caption"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Caption/)
  end
end
