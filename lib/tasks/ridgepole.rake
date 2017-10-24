# frozen_string_literal: true
namespace :ridgepole do
  desc 'ridgepole apply task'
  task :apply do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml -f db/schemas/Schemafile --apply"
  end

  desc 'ridgepole schema file export'
  task :export do
    ENV['RAILS_ENV'] ||= "development"
    sh "bundle exec ridgepole -E#{ENV['RAILS_ENV']} -c config/database.yml --export --split -o db/schemas/Schemafile"
  end
end
