FROM ruby:2.6.1

ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /withmychild

COPY . .

RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get install nodejs
RUN npm install webpack webpack-cli --save-dev --no-optional
RUN npm install --save react react-dom  --no-optional
RUN npm install --save-dev babel-core babel-loader babel-preset-env babel-preset-react --no-optional
