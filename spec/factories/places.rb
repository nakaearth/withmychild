# frozen_string_literal: true

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :place do
    # NOTE: 緯度経度 => lat: 35.55, lon: 139.53
    address '横浜市青葉区'
    tel '0451112222'

    trait :park do
      type 'Park'
      description 'これはテスト。これは公園です'
    end

    trait :cafe do
      type 'Cafe'
      description 'これはテスト。これはカフェです'
    end

    trait :restaurant do
      type 'Restaurant'
      description 'これはテスト。これはレストランです'
    end
  end
end
