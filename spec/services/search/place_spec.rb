# frozen_string_literal: true

require 'rails_helper'

describe Search::Place, broken: true do
  let(:user) { create(:user) }
  let(:cafe) { create(:place, :cafe, user: user) }
  let(:park) { create(:place, :park, user: user) }
  let(:restaurant) { create(:place, :restaurant, user: user) }
  let(:params) {}

  before do
    cafe
    park
    restaurant

    Place.create_index!
    Place.create_alias!
    Place.bulk_import
  end

  describe '#call' do
    context 'キーワードを指定しての検索' do
      let(:params) { { keyword: 'テスト' } }

      before do
        @results = Search::Place.new(params).call
      end

      it '指定した条件に合致するものが返ってくる' do
        expect(@results.size).to eq 3
      end
    end
  end
end
