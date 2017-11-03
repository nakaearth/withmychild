# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Place, type: :model do
  let!(:user) { create(:user) }
  let!(:park) { create(:place, :park, user: user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect belong_to(:user) }
      it { expect have_many(:photos) }
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
end
