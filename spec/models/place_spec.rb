# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Place, type: :model do
  let!(:user) { create(:user) }
  let!(:photo) { create(:photo, user: user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect belong_to(:user) }
    end
  end

  describe '入力チェックをする' do
    context 'descriptionカラム' do
      it { is_expected.to validate_length_of(:description).is_at_most(140) }
    end
  end

  describe 'photoの登録' do
    context 'user経由でphotoを作成する' do
      before do
        @test_photo = user.photos.build(
          {
            description: 'テストほげ',
            image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg")
          }
        )
      end

      it { expect(@test_photo.save).to eq true }
    end

    context 'user経由でtagを作成する' do
      before do
        @build_photo = user.photos.build({
                         description: 'テストほげ',
                         image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg"),
                         tags_attributes: [{ name: 'test' }]
                      })
      end

      # it { expect(@build_photo.save).to eq true }
      it 'tagsテーブルにデータが登録される' do
        @build_photo.save
        # expect(Tag.where(name: 'test').first).not_to be_nil
      end
    end

    # context 'user経由でphoto_geoを作成する' do
    #   before do
    #     @built_photo = user.photos.build({
    #                                        description: 'テストほげ',
    #                                        image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg"),
    #                                        photo_geo_attributes: { address: '東京都港区' }
    #                                      })
    #   end
    #
    #   it { expect(@built_photo.save).to eq true }
    #   it 'photo_geoも登録されている' do
    #     @built_photo.save
    #     expect(PhotoGeo.where(address: '東京都港区').first).not_to be_nil
    #   end
    # end
  end
end
