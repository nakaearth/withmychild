# frozen_string_literal: true
class PhotosController < ApplicationController
  include UserAgent
  include DecryptedId

  before_action :set_request_variant
  before_action :set_place, only: %i(index destroy)
  before_action :set_photo, only: %i(edit show destroy)

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
    @photo = @current_user.photos.build
    @places = @current_user.places
  end

  def create
    @photo = @place.photos.build(photo_params)

    if @photo.save
      redirect_to place_photos_path(place_id: Place.encrypt_id(@photo.place.id.to_s)), notice: '写真の登録がしました'
    else
      @places = @current_user.places

      render action: :new, alert: '写真の登録に失敗しました'
    end
  end

  def edit; end

  def update; end

  def destroy
    target_date_ymd = @photo.created_at_ymd
    @photo.destroy

    redirect_to place_photos_path(album_id: Album.encrypt_id(@album.id.to_s), created_at_ymd: target_date_ymd), notice: '写真を削除しました'
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_place
    @place = Places.find(Place.decrypt_id(params[:place_id]))
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    colums_name = [
      :place_id,
      :description,
      :image,
      photo_geo_attributes: [
        :address
      ],
      tags_attributes: [
        :name
      ]
    ]

    params.require(:photo).permit(colums_name)
  end
end
