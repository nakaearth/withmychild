# frozen_string_literal: true

require 'rails_helper'

describe Api::PlacesController, broken: true do
  describe 'POST /api/places' do
    let(:user) { create(:user) }
    let(:cafe) { create(:place, :cafe, user: user) }
    let(:park) { create(:place, :park, user: user) }
    let(:restaurant) { create(:place, :restaurant, user: user) }

    before do
      cafe
      park
      restaurant

      Place.create_index!(force: true)
      Place.create_alias!
      Place.bulk_import

      post api_places_path(params)
    end

    context 'user not_exist' do
      let(:params) do
        {
          keyword: 'テスト',
          uid: "11111111#{user.uid}"
        }
      end

      it { expect(response.status).to eq 404 }
    end

    context 'キーワード検索' do
      let(:params) do
        {
          keyword: 'テスト',
          uid: user.uid
        }
      end
      let(:expected_json) do
        {
          places: [
            {
              id: restaurant.id,
              description: restaurant.description,
              type: restaurant.type,
              address: restaurant.address
            },
            {
              id: park.id,
              description: park.description,
              type: park.type,
              address: park.address
            },
            {
              id: cafe.id,
              description: cafe.description,
              type: cafe.type,
              address: cafe.address
            }
          ]
        }.with_indifferent_access
      end

      it { expect(JSON.parse(response.body).with_indifferent_access).to eq expected_json }
    end
  end
end
