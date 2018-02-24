# frozen_string_literal: true

require 'optparse'

# 1) 新規にindexを作成/データのimportをする場合
# bundle exec rails runner StatusElasticsearch.execute
# 2) 既にindexがあって、再構築する場合
# bundle exec rails runner StatusElasticsearch.execute --force=true
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

    private

    def args
      options = {}

      OptionParser.new do |o|
        o.banner = "Usage: #{$PROGRAM_NAME} [options]"
        o.on('--force=OPT', 'option1') { |v| options[:force] = v }
      end.parse!(ARGV.dup)

      options
    end
  end
end
