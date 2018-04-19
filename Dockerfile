FROM ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ADD ./Procfile.development Procfile.development
ADD ./webpack.config.js webpack.config.js
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install nodejs
RUN npm init -y
RUN npm install webpack --save-dev
RUN npm install --save react react-dom  --no-optional
RUN npm install --save-dev babel-core babel-loader babel-preset-env babel-preset-react --no-optional
