FROM docker.elastic.co/elasticsearch/elasticsearch:6.0.0

RUN elasticsearch-plugin install analysis-kuromoji
RUN elasticsearch-plugin install analysis-icu
RUN elasticsearch-plugin remove x-pack

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
