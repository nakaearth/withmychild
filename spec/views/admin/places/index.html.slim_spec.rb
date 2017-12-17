# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "admin/places/index", type: :view do
  let(:user) { create(:user) }

  before(:each) do
    assign(:places, [
             create(:place, :park, user: user),
             create(:place, :cafe, user: user)
           ])
  end

  it "renders a list of admin/places" do
    render
  end
end
