# frozen_string_literal: true

module Api
  class PlacesController < Api::ApplicationController
    include EncryptionConcern

    before_action :set_user
    before_action :user_exist?
    before_action :set_photo, only: %i[update show]

    # 写真一覧をjson形式で返す
    def index
      service = Search::PlaceService.new(search_params)
      @places = service.result_record

      format.json { render 'api/places/index' }
    end

    private

    def set_user
      # TODO: 取り敢えず一旦htmlから呼び出すために追加
      return @current_user = User.last if params['uid'] == 'guest'

      @current_user = User.find_by(uid: params[:uid])
    end

    def user_exist?
      return head :not_found unless @current_user
    end

    def set_photo
      @photo = @current_user.photos.find_by(id: params[:id])
    end

    def photo_params
      columns_name = [
        :description,
        :image,
        photo_geo_attributes: [
          :address
        ]
      ]

      params.require(:photo).permit(columns_name)
    end
  end
end
