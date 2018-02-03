# frozen_string_literal: true

module Api
  class PlacesController < Api::ApplicationController
    include EncryptionConcern

    before_action :set_user
    before_action :user_exist?

    # placeの一覧をjson形式で返す
    def create
      service = Search::PlaceService.new(params)
      service.call
      @places = service.result_record
    end

    private

    def set_user
      @current_user = User.find_by(uid: params[:uid])
    end

    def user_exist?
      return head :not_found unless @current_user
    end
  end
end
