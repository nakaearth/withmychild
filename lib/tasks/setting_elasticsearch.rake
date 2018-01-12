
# frozen_string_literal: true

namespace :elasticsearch do
  desc 'elasticsearch index build'
  task index_build: :environment do
    ENV['RAILS_ENV'] ||= "development"
    logger = ActiveSupport::Logger.new("log/setting_batch.log", 'daily')
    logger.info('index作成')
    Place.create_index!(force: false)
    logger.info('alias作成')
    Place.create_alias!
    # importする
    logger.info('========= データ登録 =========')
    Place.bulk_import
    logger.info('========データ登録完了しました ========')
  end

  desc 'elasticsearch index re-build'
  task re_index_build: :environment do
    ENV['RAILS_ENV'] ||= "development"
    logger = ActiveSupport::Logger.new("log/setting_batch.log", 'daily')
    logger.info('index作成')
    Place.create_index!(force: true)
    logger.info('alias作成')
    Place.create_alias!
    # importする
    logger.info('========= データ登録 =========')
    Place.bulk_import
    logger.info('========データ登録完了しました ========')
  end
end
