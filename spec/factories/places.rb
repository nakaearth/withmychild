# frozen_string_literal: true

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :place do
    address '横浜市XX区XX 1-1-1'
    tel '0451112222'

    trait :park do
      type 'Park'
      description "これは公園です"
    end

    trait :cafe do
      type 'Cafe'
      description "これはカフェです"
    end

    trait :restaurant do
      type 'Restaurant'
      description "これはレストランです"
    end
  end
end
