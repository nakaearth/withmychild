# frozen_string_literal: true
# rubocop:disable all
module Search
  class BaseService
    def initialize(search_model_class, params)
      @client = search_model_class.__elasticsearch__
      @conditions = params
    end
  end
end
# rubocop:enable all
