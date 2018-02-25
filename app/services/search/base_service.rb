# frozen_string_literal: true
# rubocop:disable all
module Search
  class BaseService
    def initialize(search_model_class, params)
      @conditions = params
    end
  end
end
# rubocop:enable all
