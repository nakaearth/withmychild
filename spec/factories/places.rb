# frozen_string_literal: true

FactoryBot.define do
  factory :place do
    # NOTE: 緯度経度 => lat: 35.55, lon: 139.53
    address { '横浜市青葉区' }
    tel { '0451112222' }

    trait :park do
      type { 'Park' }
      description { 'これはテスト。これは公園です。高速道路の近くにあります。ムシのコレクターも結構集まります。' }
    end

    trait :cafe do
      type { 'Cafe' }
      description { 'これはテスト。これはカフェです。雨の日はテラス席が閉りますが、長めの良いカフェです' }
    end

    trait :restaurant do
      type { 'Restaurant' }
      description { 'これはテスト。これはレストランです。セレブ御用達の店です。一〇〇〇円でランチが食べられます' }
    end
  end
end
