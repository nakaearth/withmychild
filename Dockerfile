FROM ruby
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev graphviz
WORKDIR /tmp
ADD ./Gemfile Gemfile
ADD ./Gemfile.lock Gemfile.lock
ADD ./Procfile.development Procfile.development
ADD ./package.json package.json
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install nodejs
RUN npm install -D webpack babel-loader babel-preset-env babel-preset-react
RUN npm install -S react react-dom
CMD ["bundle", "exec", "foreman", "start", "-f", "Procfile.development"]
