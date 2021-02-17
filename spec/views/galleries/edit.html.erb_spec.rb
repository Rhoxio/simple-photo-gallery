require 'rails_helper'

RSpec.describe "galleries/edit", type: :view do
  before(:each) do
    @gallery = assign(:gallery, Gallery.create!(
      description: "MyText",
      title: "MyString"
    ))
  end

  it "renders the edit gallery form" do
    render

    assert_select "form[action=?][method=?]", gallery_path(@gallery), "post" do

      assert_select "textarea[name=?]", "gallery[description]"

      assert_select "input[name=?]", "gallery[title]"
    end
  end
end
