# frozen_string_literal: true

namespace :app do
  desc 'generate application token'
  task :create_token, ['application_id', 'version_id'] => :environment do |task, args|
    app_token = AppToken.new(application_id: args[:application_id], version_id: args[:version_id])
    app_token.generate_token
    app_token.save!
    puts "tokenの発酵が完了しました: #{app_token.secreat_key}"
  end
end
