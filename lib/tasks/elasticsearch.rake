# frozen_string_literal: true

namespace :elasticsearch do
  desc 'elasticsearch setup'
  task :setup => :environment do
    Place.create_index!(force: true)
    Place.create_alias!
    Place.bulk_import
  end

  desc 'data import'
  task :import => :environment do
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

  desc 'elasticsearch add ingest pipeline'
  task :create_pipeline => :environment do
    Place.__elasticsearch__.client = ElasticsearchClient.client
    Place.create_pipeline!
  end

  desc 'get ingest pipeline'
  task :get_pipeline => :environment do
    Place.__elasticsearch__.client = ElasticsearchClient.client
    pipeline_info = Place.get_pipeline!

    p pipeline_info
  end

  desc 'ingest pipeline simulate'
  task :ingest_simulate => :environment do
    Place.__elasticsearch__.client = ElasticsearchClient.client
    pipeline_info = Place.get_pipeline!

    p pipeline_info
  end
end
