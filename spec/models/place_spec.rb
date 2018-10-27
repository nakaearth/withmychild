# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Place, type: :model do
  let!(:user) { create(:user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { should belong_to(:user) }
      it { should have_many(:photos) }
    end
  end

  describe '入力チェックをする' do
    it { is_expected.to validate_length_of(:description).is_at_most(1000) }
    it { is_expected.to validate_length_of(:address).is_at_most(80) }
  end

  describe 'placeの登録' do
    context 'user経由でplaceを作成する' do
      before do
        @test_place = user.places.build(
          {
            description: 'テストほげ',
            type: 'Park'
          }
        )
      end

      it { expect(@test_place.save).to eq true }
      it { expect(@test_place.class.name).to eq 'Park' }
    end

    context 'addressに値がセットされている場合' do
      before do
        @test_place = user.places.build(
          {
            description: 'テストほげ',
            type: 'Park',
            address: '横浜市青葉区'
          }
        )
        @test_place.save
      end

      it { expect(@test_place.latitude).not_to be_nil }
      it { expect(@test_place.longitude).not_to be_nil }
    end

    # TODO: 将来的にplaceにTagつけするようにしたいかもね
    # context 'user経由でtagを作成する' do
    #   before do
    #     @build_photo = user.photos.build({
    #                      description: 'テストほげ',
    #                      image: File.open("#{Rails.root}/spec/fixtures/dog.jpeg"),
    #                      tags_attributes: [{ name: 'test' }]
    #                   })
    #   end
    #
    #   # it { expect(@build_photo.save).to eq true }
    #   it 'tagsテーブルにデータが登録される' do
    #     @build_photo.save
    #     # expect(Tag.where(name: 'test').first).not_to be_nil
    #   end
    # end
  end

  # インスタンスメソッドのdescription_summaryをテストする
  describe '#desciption_summary' do
    let(:park) { create(:place, :park, user: user, description: description) }

    context '80文字以上の場合' do
      let(:description) { 'a' * 81 }

      it { expect(park.description_summary).to eq 'a' * 80 + '...' }
    end

    context '79文字の場合' do
      let(:description) { 'a' * 79 }

      it { expect(park.description_summary).to eq 'a' * 79 }
    end
  end

  describe '#photo_image_urls' do
  end
end
