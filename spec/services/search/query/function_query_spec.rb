# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::Query::FunctionQuery do
  describe 'match_query' do
    let(:function_query) { Search::Query::FunctionQuery.new(conditions, [:description]) }

    context '' do
      let(:conditions) { { keyword: 'test', user_id: user.id } }
      let!(:user) { create(:user) }
      let(:query) do
        {
          bool: {
            must: [
              { term: { user_id: user.id } },
              {
                simple_query_string: {
                  query: 'test',
                  fields: ['description'],
                  default_operator: 'and'
                }
              }
            ]
          }
        }
      end

      it { expect(function_query.match_query).to eq query }
    end
  end
end
