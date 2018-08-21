FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.2.3

RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu

COPY --chown=elasticsearch:elasticsearch  elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
