# frozen_string_literal: true

require 'rails_helper'

xdescribe "admin/places/show", type: :view do
  before(:each) do
    @admin_place = assign(:admin_place, dlace.create!)
  end

  it "renders attributes in <p>" do
    render
  end
end
