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
    settings index: {
      number_of_shards:   5,
      number_of_replicas: 1,
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
            filter:    %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width)
          },
          ngram_analyzer: {
            tokenizer: 'ngram_tokenizer'
          }
        }
      }
    } do
      mapping _source: { enabled: true },
        _all: { enabled: true, analyzer: 'kuromoji_analyzer' } do
          indexes :id,          type: 'integer', index: 'not_analyzed'
          indexes :description, type: 'text', analyzer: 'kuromoji_analyzer'
          indexes :type,        type: 'text', analyzer: 'kuromoji_analyzer'
          indexes :tel,         type: 'text', analyzer: 'kuromoji_analyzer'
          indexes :user_id,     type: 'integer', index: 'not_analyzed'
          indexes :likes,       type: 'integer', index: 'not_analyzed'
          indexes :address,     type: 'text', analyzer: 'kuromoji_analyzer'
          indexes :location,    type: 'geo_point' do
            indexes :lat,       type: 'string', index: 'not_analyzed'
            indexes :lon,       type: 'string', index: 'not_analyzed'
          end
          indexes :tags,        type: 'nested' do
            indexes :name,      type: 'keyword', index: 'not_analyzed'
          end
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
      __elasticsearch__.client.index  index: Settings.elasticsearch[:index_name], type: 'place', id: id, body: as_indexed_json
    end

    def remove_from_elasticsearch
      __elasticsearch__.client.delete index: Settings.elasticsearch[:index_name], type: 'place', id: id
    end
  end

  class_methods do
    def create_index!(options = {})
      client = __elasticsearch__.client
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
      # client = __elasticsearch__.client
      # if client.indices.exists_alias?(name: Settings.elasticsearch[:alias_name])
      #   client.indices.delete_alias(index: Settings.elasticsearch[:index_name], name: Settings.elasticsearch[:alias_name])
      # end
      #
      # client.indices.put_alias(index: Settings.elasticsearch[:index_name], name: Settings.elasticsearch[:alias_name])
    end

    def bulk_import
      es = __elasticsearch__

      find_in_batches.with_index do |entries, _i|
        es.client.bulk(
          index: Settings.elasticsearch[:index_name],
          type: 'place',
          body: entries.map { |entry| { index: { _id: entry.id, data: entry.as_indexed_json } } },
          refresh: true, # NOTE: 定期的にrefreshしないとEsが重くなる
        )
      end
    end
  end
  # rubocop:enable all

  private

  def as_indexed_json_tag(_options = {})
    return {} unless tags

    { tags: tags.map(&:attributes) }
  end
end
