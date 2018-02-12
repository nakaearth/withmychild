# frozen_string_literal: true

namespace :api do
  desc "places apiのテスト 実行方法: rake api:places'"
  task :places => :environment do
    params = { keyword: '公園' }

    service = Search::PlaceService.new(params)
    service.call
    p service.result_record
  end
end
