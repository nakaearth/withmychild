# frozen_string_literal: true

module Search
  class PlaceService < BaseService
    def initialize(params)
      super(Place, params)
    end

    def call
      Place.__elasticsearch__.client = ElasticsearchClient.client
      Place.__elasticsearch__.index_name = Settings.elasticsearch[:index_name]
      @response = Place.search(query)
    end

    def result_record
      @response.records.to_a
    end

    def hits_count
      @response.records
    end

    def aggregations
      @response.aggregations
    end

    private

    # TODO: GEO関数を使うように後々変更する
    def query
      {
        query: {
          function_score: {
            score_mode: 'sum', # functionsないのスコアの計算方法
            boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
            query: {
              bool: {
                must: Search::Query::FunctionQuery.new(@conditions, ['description']).and_query,
                filter: Search::Query::GeoLocationQuery.new(@conditions).geo_query
              }
            },
            functions: [
              {
                field_value_factor: {
                  field: "likes",
                  factor: 2.0,
                  modifier: "square",
                  missing: 1
                },
                weight: 5
              },
              {
                field_value_factor: {
                  field: "id",
                  factor: 3,
                  modifier: "sqrt", # squt: ルート, log: 指数関数
                  missing: 1
                },
                weight: 2
              }
            ]
          }
# TODO: aggregationを設定する
        },
        aggs: {
          tag: {
            terms: {
              field: 'tag_name',
              size: 50
            }
          }
        },
        from: @conditions[:page] || 0,
        size: 20,
        sort: { id: { order: 'desc' } }
      }.to_json
    end
  end
end
