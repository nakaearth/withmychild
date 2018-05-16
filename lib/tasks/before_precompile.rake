# frozen_string_literal: true

task :build_frontend do
  sh "npm install"
  sh "npm run build:prd"
end

Rake::Task["assets:precompile"].enhance(%i[build_frontend]) if Rails.env.production?
