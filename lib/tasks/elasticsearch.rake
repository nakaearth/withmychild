# frozen_string_literal: true

namespace :elasticsearch do
  desc 'elasticsearch setup'
  task :setup do
    ENV['RAILS_ENV'] ||= "development"
    Place.create_index!(force: true)
    Place.create_alias!
    Place.bulk_import
  end
end
