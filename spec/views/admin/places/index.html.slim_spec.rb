# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "admin/places/index", type: :view do
  before(:each) do
    assign(:admin_places, [
             Place.create!,
             Place.create!
           ])
  end

  it "renders a list of admin/places" do
    render
  end
end
