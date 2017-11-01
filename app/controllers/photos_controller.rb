# frozen_string_literal: true
class PhotosController < ApplicationController
  include UserAgent
  include DecryptedId

  before_action :set_request_variant
  before_action :set_album, only: %i(index destroy)
  before_action :set_photo, only: %i(edit show destroy)
  before_action :set_shared_album, only: %i(index)

  def index
    respond_to do |format|
      @photos = @album.photos.page(params[:page])
      format.html

      format.json { render 'api/photos/index' }
    end
  end

  def show
    render partial: 'show', format: :html
  end

  def close
    @photos = @current_user.photos.page(params[:page])

    render partial: 'close', format: :html
  end

  def new
    @photo = @current_user.photos.build

    @albums = @current_user.albums
  end

  def create
    @photo = @current_user.photos.build(photo_params)

    if Photo.with_writable { @photo.save }
      redirect_to album_photos_path(album_id: Album.encrypt_id(@photo.album.id.to_s)), notice: '写真の登録がしました'
    else
      @albums = @current_user.albums

      render action: :new, alert: '写真の登録に失敗しました'
    end
  end

  def edit; end

  def update; end

  def destroy
    target_date_ymd = @photo.created_at_ymd
    @photo.destroy

    redirect_to album_daily_photos_path(album_id: Album.encrypt_id(@album.id.to_s), created_at_ymd: target_date_ymd), notice: '写真を削除しました'
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_album
    @album = @current_user.albums.where(id: Album.decrypt_id(params[:album_id])).first
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def set_shared_album
    @shared_album = SharedAlbum.new(album: @album)
  end

  def photo_params
    colums_name = [
      :album_id,
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
