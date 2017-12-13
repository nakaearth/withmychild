# frozen_string_literal: true
# rubocop:disable all
module Search
  class BaseService
    def initialize(search_model_class, params)
      if search_model_class.columns { |column| column.type == 'text' }.any?
        @client = search_model_class.__elasticsearch__
      else
        raise "Format error: #{search_model_class} do not have text type column"
      end

      @conditions = params
    end
  end
end
# rubocop:enable all
