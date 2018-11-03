# frozen_string_literal: true

class PhotosController < ApplicationController
  include UserAgent
  include DecryptedId

  # ログイン機能が不要skip
  skip_before_action :login?
  before_action :set_place, only: %i[index new create]
  before_action :set_photo, only: %i[edit show destroy]

  def index
    respond_to do |format|
      @photos = @place.photos.page(params[:page])
      format.html

      format.json { render 'api/photos/index' }
    end
  end

  def show
    render partial: 'show', format: :html
  end

  def new
    @photo = @place.photos.build
  end

  def create
    @photo = @place.photos.build(photo_params)

    begin
      @photo.save!
      redirect_to place_path(id: Place.encrypt_id(@photo.place.id.to_s)), notice: '写真の登録がしました'
    rescue ActiveRecord::RecordInvalid => e
      @places = @current_user.places
      # TODO: ここエラーログはログ出力させたいっすね
      logger.error(error_message: e.record.errors)

      render action: :new, alert: '写真の登録に失敗しました'
    end
  end

  def edit; end

  def update; end

  def destroy
    @photo.destroy

    redirect_to place_photos_path(place_id: Place.encrypt_id(@album.id.to_s), notice: '写真を削除しました')
  end

  private

  def set_place
    @place = Place.find(Place.decrypt_id(params[:place_id]))
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    colums_name = [
      :place_id,
      :image,
    ]

    params.permit(colums_name)
  end
end
