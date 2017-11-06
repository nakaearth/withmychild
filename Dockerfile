FROM ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install nodejs
RUN npm install yarn@0.28.4 -g
