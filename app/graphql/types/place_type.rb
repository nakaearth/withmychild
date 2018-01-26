# frozen_string_literal: true

Types::PlaceType = GraphQL::ObjectType.define do
  name "Place"
  field :id, !types.ID
  field :name, !types.String
  field :description, !types.String
  field :type, !types.String
  field :user_id, !Types::IntegerType
  field :address, !types.String
  field :lat, !types.String
  field :lot, !types.String
  field :tag_name, !types.String
end
