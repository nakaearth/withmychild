# frozen_string_literal: true

require 'rails_helper'

describe Search::PlaceService, broken: true do
  let(:user) { create(:user) }
  let!(:cafe) { create(:place, :cafe, user: user) }
  let!(:park) { create(:place, :park, user: user) }
  let!(:restaurant) { create(:place, :restaurant, user: user) }
  let(:params) {}

  before do
    Place.create_index!(force: true)
    # Place.create_alias!
    Place.bulk_import
    @service = Search::PlaceService.new(params)
    @service.call
  end

  describe '#call' do
    context 'キーワードを指定しての検索' do
      let(:params) { { keyword: 'テスト' } }

      it '指定した条件に合致するものが返ってくる(件数チェック)' do
        expect(@service.hits_count.size).to eq 3
      end

      it '指定した条件に合致するものが返ってくる' do
        expect(@service.result_record[0].description).to eq restaurant.description
        expect(@service.result_record[1].description).to eq park.description
        expect(@service.result_record[2].description).to eq cafe.description
      end
    end

    context 'typeを絞り込んで検索' do
      let(:params) { { keyword: 'テスト', type: 'Cafe' } }

      it 'Typeが一致する物のみ検索にヒットする' do
        expect(@service.hits_count.size).to eq 1
      end

      it 'Typeが一致する物のみ検索にヒットする' do
        expect(@service.result_record[0].description).to eq cafe.description
      end
    end

    context '位置情報による絞り込みを行う場合' do
      let(:params) { { location: { distance: '10km', lat: 35.5, lon: 139.5 } } }

      it '位置情報に引っかかったものだけが検索にヒットする' do
        expect(@service.hits_count.size).to eq 3
      end

      it '位置情報に引っかかったものだけが検索にヒットする' do
        expect(@service.result_record[0].description).to eq restaurant.description
        expect(@service.result_record[1].description).to eq park.description
        expect(@service.result_record[2].description).to eq cafe.description
      end
    end

    context '位置情報による絞り込みを行う場合(distanceがないときはデフォルト値で範囲検索)' do
      let(:params) { { location: { lat: 35.5, lon: 139.5 } } }

      it '位置情報に引っかかったものだけが検索にヒットする' do
        expect(@service.hits_count.size).to eq 3
      end

      it '位置情報に引っかかったものだけが検索にヒットする' do
        expect(@service.result_record[0].description).to eq restaurant.description
        expect(@service.result_record[1].description).to eq park.description
        expect(@service.result_record[2].description).to eq cafe.description
      end
    end

    context '位置情報による絞り込みを行う場合(該当するデータがない場合)' do
      let(:params) { { location: { distance: '1km', lat: 40.5, lon: 139.5 } } }

      it '位置情報に引っかかったものだけが検索にヒットする' do
        expect(@service.hits_count.size).to eq 0
      end
    end
  end
end
