# frozen_string_literal: true

module Api
  class PhotosController < Api::ApplicationController
    include EncryptionConcern

    before_action :set_user
    before_action :user_exist?
    before_action :set_photo, only: %i[update show]

    # 写真一覧をjson形式で返す
    def index
      @photos = @current_user.photos

      render json: @photos
    end

    def show
      render json: @photo
    end

    # 写真を投稿する
    def create
      ActiveRecord::Base.transaction do
        Photos::UploadService.execute(@current_user, photo_params)

        render json: { status: :ok }
      end
    rescue ActiveRecord::RecordInvalid => e
      logger.error e.message

      render json: { status: :error, error_msg: e.message }
    end

    def update; end

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
