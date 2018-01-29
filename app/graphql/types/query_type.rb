# frozen_string_literal: true

Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :place, !Types::PlaceType do
    description "An example field added by the generator"
    resolve ->(_obj, _args, _ctx) {
      ctx[:current_user]
    }
  end
end
