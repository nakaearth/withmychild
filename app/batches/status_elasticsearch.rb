# frozen_string_literal: true
# bundle exec rails runner StatusElasticsearch.execute
#
class StatusElasticsearch
  class << self
    def execute
      logger = ActiveSupport::Logger.new("log/setting_batch.log", 'daily')
      force = args[:force] || false

      logger.info('index作成')
      logger.info('========= indexのstatusを表示 =========')
      status = ElasticsearchClient.client.indices.status
      p status
    end
  end
end
