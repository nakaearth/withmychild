# frozen_string_literal: true

namespace :elasticsearch do
  desc 'elasticsearch setup'
  task :setup do
    ENV['RAILS_ENV'] ||= "development"
    Place.create_index!(force: true)
    Place.create_alias!
    Place.bulk_import
  end

  desc 'elasticsearch status'
  task :status do
    ENV['RAILS_ENV'] ||= "development"
    ElasticsearchClient.client.indices.status index: Settings.elasticsearch[:index_name]
  end
end
