# elasticsearchの設定ファイルを読み込む
module ElasticsearchConfig
  CONFIG ||= YAML.load_file("#{Rails.root}/config/elasticsearch.yml")[ENV['RAILS_ENV'] || 'development'].with_indifferent_access
end

class ElasticsearchClient
  class << self
    def client
      if ENV['RAILS_ENV'] == 'production'
        return connection_to_bonsai
      end

      connection_to_local
    end

    private

    def hosts
     [{ host: ElasticsearchConfig::CONFIG[:host], port: ElasticsearchConfig::CONFIG[:port] }]
    end

    def url
      ElasticsearchConfig::CONFIG[:url]
    end


    def connection_to_local
      Elasticsearch::Client.new(
        hosts: hosts,
        randomize_hosts: true,
        request_timeout: 10,
        reload_connections: 500,
        sniffer_timeout: 3,
        reload_on_failure: false,
        log: false
      )
    end

    def connection_to_bonsai
      require 'faraday_middleware/aws_signers_v4'

      Elasticsearch::Client.new(
        url: url,
        randomize_hosts: true,
        request_timeout: 10,
        reload_connections: false,
        sniffer_timeout: 3,
        reload_on_failure: false,
        transport_options: { headers: { content_type: 'application/json' } },
        log: true
      )
    end
  end
end
