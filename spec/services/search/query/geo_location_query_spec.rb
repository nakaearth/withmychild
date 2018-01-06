# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::Query::GeoLocationQuery do
  describe 'geo_query' do
    let(:geo_location_query) { Search::Query::GeoLocationQuery.new(conditions) }
    let!(:user) { create(:user) }

    context 'locationがセットされている' do
      let(:conditions) { { location: { distance: '200km', lat: 35.55, lon: 139.53 } } }
      let(:geo_query) do
        {
          geo_distance: {
            distance: '200km',
            location: {
              lat: 35.55,
              lon: 139.53
            }
          }
        }
      end

      it { expect(geo_location_query.geo_query).to eq geo_query }
    end

    context 'distnceがセットされていないが他のlocationパラメータがセットされている' do
      let(:conditions) { { location: { lat: 35.55, lon: 139.53 } } }
      let(:geo_query) do
        {
          geo_distance: {
            distance: '100km',
            location: {
              lat: 35.55,
              lon: 139.53
            }
          }
        }
      end

      it { expect(geo_location_query.geo_query).to eq geo_query }
    end
  end
end
