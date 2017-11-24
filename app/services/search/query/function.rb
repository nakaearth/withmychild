# frozen_string_literal: true

module Search
  module Query
    class Function
      def initialize(input_params, target_fields)
        @conditions = input_params
        @functions  = []
        @fields     = target_fields
      end
    end
  end
end
