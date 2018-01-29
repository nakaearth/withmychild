# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photos::PhotoUploading, broken: true do
  let(:photo_params) do
    {
      image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg")
    }
  end

  let(:user) { create(:user) }
  let(:place) { create(:place, :cafe, user: user) }

  describe 'file_upload' do
    context '地域情報なし' do
      before do
        user
        place
        Photos::PhotoUploading.execute(place, photo_params)
      end

      it { expect(Place.find(place.id).photos.count).to be > 0 }
    end

    # TODO: nested_attributeの動きが違う？要確認!!!!
    # context '地域情報あり' do
    #   let(:photo_params) do
    #     {
    #       description: 'これはテスト',
    #       image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg"),
    #       photo_geo_attributes: { address: '東京都渋谷区' }
    #     }
    #   end
    #
    #   before do
    #     user
    #     Photos::PhotoUploding.execute(user, photo_params)
    #   end
    #
    #   # it { expect(User.find(user.id).photos.count).to be > 0 }
    #   # it { expect(User.find(user.id).photos.last.photo_geo).not_to be_nil }
    # end
  end

  describe '例外' do
    context 'file_upload_error' do
      let(:photo_params) do
        {
          image: File.open("#{Rails.root}/spec/fixtures/test.txt")
        }
      end

      it { expect { Photos::PhotoUploading.execute(place, photo_params) }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end
end
