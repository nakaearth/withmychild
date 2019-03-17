# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "テスト太郎" }
    email { "test@gmail.com" }
    decrypted_password { "これはテストです" }
    provider { "test_provider" }
    nickname { 'ほげking' }
    uid { Base64.encode64('aabbccdd123') }
    access_token { "12345aabc" }

    trait :facebook do
      provider { "facebook" }
    end

    trait :twitter do
      provider { "twitter" }
    end
  end
end
