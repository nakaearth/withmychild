require 'rails_helper'

RSpec.describe "admin/places/edit", type: :view do
  before(:each) do
    @admin_place = assign(:admin_place, Admin::Place.create!())
  end

  it "renders the edit admin_place form" do
    render

    assert_select "form[action=?][method=?]", admin_place_path(@admin_place), "post" do
    end
  end
end
