# frozen_string_literal: true

FactoryBot.define do
  factory :app_token do
    application_id { 'test_app' }
    version_id { '1.0.0' }
    secreat_key { '12345789abcdefg' }
  end
end
