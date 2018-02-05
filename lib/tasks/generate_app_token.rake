# frozen_string_literal: true

namespace :app do
  desc "generate application token. 実行方法: rake 'create_token[application_id, version_id]'"
  task :create_token, [:application_id, :version_id] => :environment do |task, args|
    return if args.count != 2

    application_id = args[:application_id]
    version_id     = args[:version_id]
    app_token = AppToken.find_or_create_by(application_id: application_id, version_id: version_id) do |app_token|
      app_token.generate_token
    end
    puts "tokenを発行完了しました: #{app_token.secreat_key}"
  end
end
