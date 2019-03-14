# frozen_string_literal: true

module PlaceSearchable
  extend ActiveSupport::Concern

  # rubocop:disable all
  included do
    include Elasticsearch::Model

    unless Rails.env.test?
      after_save :transfer_to_elasticsearch
      after_destroy :remove_from_elasticsearch
    end

    index_name = Settings.elasticsearch[:index_name]
    document_type = 'place'

    # Set up index configuration and mapping
    # kuromoji_part_of_speech: 不要な品詞の除去
    # kuromoji_baseform token filter: 活用により変わる物を統一化
    # kuromoji_readingform: 読み方が違っても同じ意味の物をヒットできるようにする
    # kuromoji_stemmer: 最後の長音を削除(プリンター => プリンタ)
    # kuromoji_number: 漢数字を数字に修正
    #
    settings index: {
      number_of_shards:   2,
      number_of_replicas: 1,
      default_pipeline: 'place_pipeline',

      analysis: {
        filter: {
          pos_filter: {
            type:     'kuromoji_part_of_speech',
            stoptags: ['助詞-格助詞-一般', '助詞-終助詞']
          },
          greek_lowercase_filter: {
            type:     'lowercase',
            language: 'greek'
          },
          kuromoji_ks: {
            type: 'kuromoji_stemmer',
            minimum_length: '5'
          }
        },
        tokenizer: {
          kuromoji: {
            type: 'kuromoji_tokenizer'
          },
          ngram_tokenizer: {
            type: 'nGram',
            min_gram: '2',
            max_gram: '3',
            token_chars: %w(letter digit)
          }
        },
        analyzer: {
          kuromoji_analyzer: {
            type:      'custom',
            tokenizer: 'kuromoji_tokenizer',
            filter:    %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width kuromoji_number kuromoji_stemmer)
          },
          ngram_analyzer: {
            tokenizer: 'ngram_tokenizer'
          }
        }
      }
    } do
      mapping _source: { enabled: true } do
        indexes :id,          type: 'integer'
        indexes :description, type: 'text', analyzer: 'kuromoji_analyzer'
        indexes :type,        type: 'keyword'
        indexes :latitude,    type: 'float'
        indexes :longitude,   type: 'float'
        indexes :tel,         type: 'text', analyzer: 'kuromoji_analyzer'
        indexes :user_id,     type: 'integer'
        indexes :likes,       type: 'integer'
        indexes :address,     type: 'text', analyzer: 'kuromoji_analyzer'
        indexes :location,    type: 'geo_point'
        indexes :tags,        type: 'nested' do
          indexes :name,      type: 'keyword'
        end
        indexes :search_test, type: 'text', analyzer: 'kuromoji_analyzer'
        indexes :created_at,  type: 'date', format: 'date_time'
        indexes :updated_at,  type: 'date', format: 'date_time'
      end
    end

    # TODO: tagsテーブルの値をいれる
    def as_indexed_json(options = {})
      as_json.
        merge({ type: type }).
        merge( location: { lat: latitude.try(:to_s), lon: longitude.try(:to_s) }).
        merge(as_indexed_json_tag(options))
    end

    def transfer_to_elasticsearch
      # ElasticsearchClient.client.index index: Settings.elasticsearch[:index_name], type: 'place', id: id, body: as_indexed_json, pipeline: 'place_pipeline'
      ElasticsearchClient.client.index index: Settings.elasticsearch[:index_name], type: '_doc', id: id, body: as_indexed_json
    end

    def remove_from_elasticsearch
      ElasticsearchClient.client.delete index: Settings.elasticsearch[:index_name], type: '_doc', id: id
    end
  end

  class_methods do
    def create_index!(options = {})
      client = ElasticsearchClient.client
      if options[:force]
        client.indices.delete index: Settings.elasticsearch[:index_name] if client.indices.exists? index: Settings.elasticsearch[:index_name]
      end

      client.indices.create(
        index: Settings.elasticsearch[:index_name],
        body: {
          settings: settings.to_hash,
          mappings: mappings.to_hash
        }
      )
    end

    def create_alias!
      # client = ElasticsearchClient.client
      # if client.indices.exists_alias?(name: Settings.elasticsearch[:alias_name])
      #   client.indices.delete_alias(index: Settings.elasticsearch[:index_name], name: Settings.elasticsearch[:alias_name])
      # end
      #
      # client.indices.put_alias(index: Settings.elasticsearch[:index_name], name: Settings.elasticsearch[:alias_name])
    end

    def bulk_import
      client = ElasticsearchClient.client

      find_in_batches.with_index do |entries, _i|
        client.bulk(
          index: Settings.elasticsearch[:index_name],
          type: '_doc',
          body: entries.map { |entry| { index: { _id: entry.id, data: entry.as_indexed_json } } },
          refresh: true, # NOTE: 定期的にrefreshしないとEsが重くなる
        )
      end
    end

    def create_pipeline!
      client = ElasticsearchClient.client
      client.ingest.put_pipeline(
        id: 'place_pipeline',
        body: {
          processors: [
            { set: { field: "search_test", value: "{{description}} {{tel}}" } }
          ]
        }
      )
    end

    def get_pipeline!
      client = ElasticsearchClient.client
      client.ingest.get_pipeline(
        id: 'place_pipeline'
      )
    end
  end
  # rubocop:enable all

  private

  def as_indexed_json_tag(_options = {})
    return {} unless tags

    { tags: tags.map(&:attributes) }
  end
end
