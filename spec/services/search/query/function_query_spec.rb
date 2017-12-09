# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search::Query::FunctionQuery do
  describe 'match_query' do
    let(:function_query) { Search::Query::FunctionQuery.new(conditions, [:description]) }
    let!(:user) { create(:user) }

    context 'keywordでの検索' do
      let(:conditions) { { keyword: 'test' } }
      let(:must_queries) do
        [
          {
            simple_query_string: {
              query: 'test',
              fields: ['description'],
              default_operator: 'and'
            }
          }
        ]
      end

      it { expect(function_query.and_query).to eq must_queries }
    end

    context 'keywordとtypeでの検索' do
      let(:conditions) { { keyword: 'test', type: 'cafe' } }
      let(:must_queries) do
        [
          {
            term: {
              type: 'cafe'
            }
          },
          {
            simple_query_string: {
              query: 'test',
              fields: ['description'],
              default_operator: 'and'
            }
          }
        ]
      end

      it { expect(function_query.and_query).to eq must_queries }
    end
  end
end
