# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::PlacesController, type: :routing do
  describe "routing" do
    xit "routes to #index" do
      expect(get: "/admin/places").to route_to("admin/places#index")
    end

    xit "routes to #new" do
      expect(get: "/admin/places/new").to route_to("admin/places#new")
    end

    xit "routes to #show" do
      expect(get: "/admin/places/1").to route_to("admin/places#show", id: "1")
    end

    xit "routes to #edit" do
      expect(get: "/admin/places/1/edit").to route_to("admin/places#edit", id: "1")
    end

    xit "routes to #create" do
      expect(post: "/admin/places").to route_to("admin/places#create")
    end

    xit "routes to #update via PUT" do
      expect(put: "/admin/places/1").to route_to("admin/places#update", id: "1")
    end

    xit "routes to #update via PATCH" do
      expect(patch: "/admin/places/1").to route_to("admin/places#update", id: "1")
    end

    xit "routes to #destroy" do
      expect(delete: "/admin/places/1").to route_to("admin/places#destroy", id: "1")
    end
  end
end
