# frozen_string_literal: true

require 'optparse'

# 1) 新規にPipelineを作成する場合
# bundle exec rails runner SetupIngestElasticsearch.execute
#
class SetupIngestElasticsearch
  class << self
    def execute
      logger = ActiveSupport::Logger.new("log/setting_ingest_batch.log", 'daily')
      logger.info('===== pipeline作成 =====')
      Place.__elasticsearch__.client = ElasticsearchClient.client
      Place.create_pipeline!
      logger.info('======= pipeline登録完了しました =======')
    end
  end
end
