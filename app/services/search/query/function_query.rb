# frozen_string_literal: true

module Search
  module Query
    class FunctionQuery < Function
      def match_query
        {
          bool: {
            must: [
              { term: { user_id: @conditions[:user_id] } },
              {
                simple_query_string: {
                  query: @conditions[:keyword],
                  fields: [@fields.join(',').to_s],
                  default_operator: 'and'
                }
              }
            ]
          }
        }
      end
    end
  end
end
