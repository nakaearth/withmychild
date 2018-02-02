# frozen_string_literal: true

class PlacesController < ApplicationController
  include UserAgent
  include DecryptedId

  # before_action :set_request_variant
  before_action :set_place, only: %i[edit show destroy]
  before_action :set_search_form, only: %i[create]

  def index
    respond_to do |_format|
      service = Search::PlaceService.new(search_params)
      @places = service.result_record
    end
  end

  def show; end

  def new
    @place = @current_user.places.build
  end

  def create
    service = Search::PlaceService.new(search_params)
    service.call
    @places = service.result_record
  rescue ActiveRecord::RecordInvalid => e
    # TODO: ここエラーログはログ出力させたいっすね
    logger.error(error_message: e.message)

    render action: :new, alert: '検索処理に失敗しました'
  end

  def edit; end

  def update; end

  def destroy
    target_date_ymd = @place.created_at_ymd
    @place.destroy

    redirect_to place_photos_path(place_id: Place.encrypt_id(@place.id.to_s), created_at_ymd: target_date_ymd), notice: '写真を削除しました'
  end

  private

  def set_request_variant
    request.variant = :tablet if tablet?
    request.variant = :phone if mobile?
  end

  def set_place
    @place = Place.find(Place.decrypt_id(params[:id]))
  end

  def set_search_form
    @search_form = SearchForm.new
  end

  def place_params
    colums_name = [
      :description,
      photo_attributes: [
        :image
      ],
      tags_attributes: [
        :name
      ]
    ]

    params.require(:place).permit(colums_name)
  end

  def search_params
    permitted_params = [
      :keyword
    ]

    params.require(:search_form).permit(permitted_params)
  end
end
