# frozen_string_literal: true

module Api
  class PlacesController < Api::ApplicationController
    include EncryptionConcern

    # placeの一覧をjson形式で返す
    def create
      service = Search::PlaceService.new(params)
      service.call
      @places = service.result_record
    end
  end
end
