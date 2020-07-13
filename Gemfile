source 'https://rubygems.org'
ruby '2.6.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
# Use sqlite3 as the database for Active Record
gem 'mysql2'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.1.10'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# faster jbuilder
gem 'jb'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# スキーマ管理
gem 'ridgepole', '0.8.8'
# 初期データの投入
gem 'seed-fu', '~> 2.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.7'
  gem 'selenium-webdriver'
  # コーディング規約チェック
  gem 'rubocop'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-rubocop'
  gem 'terminal-notifier-guard'
  gem "pry-rails"
  gem "pry-doc"
  gem 'pry-byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
  # 静的解析
  gem "rubycritic", :require => false
  gem 'pre-commit'
end

group :test do
  gem 'rspec-rails'
  gem 'rspec-mocks'
  # rakeのテスト用
  gem 'rake_shared_context'
  gem 'rspec-request_describer'
  gem 'factory_bot_rails'
  gem 'database_rewinder'
  gem 'shoulda-matchers'
  # コードカバレッジ
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  # coverallsとの連携
  gem 'coveralls', require: false
  gem 'request_store'
  # 良い書き方しているかチェック
  gem 'rails_best_practices'
  gem 'rb-readline'
#  gem "rake-compiler"
  # プロファイリング
  # gem 'stackprof'
  # gem 'stackprof-webnav'
  # 静的解析
  gem 'brakeman', require: false
end

group :production do
  gem 'cloudinary'
end

  # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# 認証
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-google-oauth2'

# バッチ処理
gem 'whenever',  :require => false

# template engine
gem "slim-rails"
# TODOのやつだったかな？
gem "watson-ruby"
# 画像アップロード
gem 'carrierwave'
gem 'mini_magick'
# 画像ライブラリ
gem 'rmagick'
# 位置情報
gem 'geocoder'
# decorator
gem "active_decorator"
# pagenate
gem 'kaminari'
gem 'nokogiri'
# 暗号化
gem 'attr_encrypted'
# プロセス管理
gem 'foreman'
# elasticsearch
gem 'elasticsearch-rails', '~> 6'
gem 'elasticsearch-model', '~> 6'
gem 'faraday_middleware-aws-signers-v4'
# 定数設定
gem 'config'
# UI framework
gem 'semantic-ui-sass'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'twitter-bootstrap-rails'
gem 'bootstrap-modal-rails'
# ブラウザ判定、UA判定に使う
gem 'browser'
# controllerのパラメータチェック
gem 'weak_parameters'
# graphql
gem 'graphql'

gem 'graphiql-rails', group: :development
# Google Places API
gem 'google_places'

# ドキュメント生成
gem 'yard'
