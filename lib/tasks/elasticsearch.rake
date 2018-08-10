# frozen_string_literal: true

namespace :elasticsearch do
  desc 'elasticsearch setup'
  task :setup => :environment do
    Place.create_index!(force: true)
    Place.create_alias!
    Place.bulk_import
  end

  desc 'elasticsearch status'
  task :status => :environment do
    ElasticsearchClient.client.indices.status index: Settings.elasticsearch[:index_name]
  end

  desc 'elasticsearch index clear'
  task :clear_index => :environment do
    ElasticsearchClient.client.indices.delete index: Settings.elasticsearch[:index_name]
  end
end
