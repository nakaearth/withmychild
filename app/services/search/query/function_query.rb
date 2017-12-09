# frozen_string_literal: true

module Search
  module Query
    class FunctionQuery < Function
      def and_query
        results = []
        results << type_terms_query if @conditions[:type]
        results << match_query
        results
      end

      private

      def type_terms_query
        { term: { type: @conditions[:type] } }
      end

      def match_query
        {
          simple_query_string: {
            query: @conditions[:keyword],
            fields: [@fields.join(',').to_s],
            default_operator: 'and'
          }
        }
      end
    end
  end
end
