FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ADD ./Rakefile Rakefile
ADD ./Procfile.development Procfile.development
ADD ./Procfile Procfile
ADD ./webpack.config.js webpack.config.js
ADD ./package.json package.json
ADD ./package-lock.json package-lock.json
ADD ./node_modules node_modules
ADD ./node_modules node_modules
ADD ./.babelrc .babelrc
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install nodejs
RUN npm install webpack webpack-cli --save-dev --no-optional
RUN npm install -g ajv@^6.0.0
RUN npm install --save react react-dom  --no-optional
RUN npm install --save-dev babel-core babel-loader babel-preset-env babel-preset-react --no-optional
