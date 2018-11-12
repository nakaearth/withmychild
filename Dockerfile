FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /tmp
COPY ./Gemfile Gemfile
COPY ./Gemfile.lock Gemfile.lock
COPY ./Rakefile Rakefile
COPY ./Procfile.development Procfile.development
COPY ./Procfile Procfile
COPY ./webpack.config.js webpack.config.js
COPY ./package.json package.json
COPY ./package-lock.json package-lock.json
COPY ./.babelrc .babelrc
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  apt-get install nodejs
RUN npm install webpack webpack-cli --save-dev --no-optional
RUN npm install --save react react-dom  --no-optional
RUN npm install --save-dev babel-core babel-loader babel-preset-env babel-preset-react --no-optional
