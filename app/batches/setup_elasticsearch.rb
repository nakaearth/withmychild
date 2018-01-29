# frozen_string_literal: true

require 'optparse'

# 1) 新規にindexを作成/データのimportをする場合
# bundle exec rails runner SetupElasticsearch.execute
# 2) 既にindexがあって、再構築する場合
# bundle exec rails runner SetupElasticsearch.execute --force=true
#
class SetupElasticsearch
  class << self
    def execute
      logger = ActiveSupport::Logger.new("log/setting_batch.log", 'daily')
      force = args[:force] || false

      puts("RAILS_ENV: #{ENV['RAILS_ENV']}")
      puts("本番環境です") if Rails.env.production?
      logger.info('index作成')
      Place.create_index!(force: force)
      logger.info('alias作成')
      Place.create_alias!
      # importする
      logger.info('========= データ登録 =========')
      Place.bulk_import
      logger.info('========データ登録完了しました ========')
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
