# frozen_string_literal: true

include ActionDispatch::TestProcess

FactoryBot.define do
  factory :photo do
    image { fixture_file_upload("#{::Rails.root}/spec/fixtures/dog.jpeg", 'image/png') }
  end
end
