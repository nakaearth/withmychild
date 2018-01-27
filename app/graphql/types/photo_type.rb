# frozen_string_literal: true

Types::PhotoType = GraphQL::ObjectType.define do
  name "Photo"
  field :id, !types.ID
  field :image, !types.String
  field :place_id, !Types::IntegerType
end
