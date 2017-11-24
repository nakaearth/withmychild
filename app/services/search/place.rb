module Search
  class Place << Base
    def call
      @client.index_name = Settings.elasticsearch[:index_name]
      @response = @client.search(query)
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

    def query
      {
        min_score: 20,
        query: {
          function_score: {
            score_mode: 'sum', # functionsないのスコアの計算方法
            boost_mode: 'multiply', # クエリの合計スコアとfunctionのスコアの計算方法
            query: Search::Query::FunctionQuery.new(@conditions, ['description']).match_query,
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
        }
      }.to_json
    end
  end
end
