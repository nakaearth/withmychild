# frozen_string_literal: true

module Admin
  class PlacesController < ApplicationController
    before_action :set_place, only: %i[edit update destroy]

    # GET /admin/places
    def index
      @places = Place.all
    end

    # GET /admin/places/new
    def new
      @place = Place.new
    end

    # GET /admin/places/1/edit
    def edit; end

    # POST /admin/places
    def create
      @place = Place.new(place_params)
      @place.user = current_user
      if @place.save
        redirect_to admin_places_url, notice: 'Place was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin/places/1
    def update
      if @place.update(place_params)
        redirect_to admin_places_url, notice: 'Place was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/places/1
    def destroy
      @place.destroy
      redirect_to admin_places_url, notice: 'Place was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require("place").permit(:name, :description, :address, :tell, :type)
    end
  end
end

