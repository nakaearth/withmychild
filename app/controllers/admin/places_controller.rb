# frozen_string_literal: true

module Admin
  class PlacesController < ApplicationController
    before_action :set_place, only: %i[show edit update destroy]

    # GET /admin/places
    def index
      @places = Place.all
    end

    # GET /admin/places/1
    def show
    end

    # GET /admin/places/new
    def new
      @place = Place.new
    end

    # GET /admin/places/1/edit
    def edit
    end

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
      respond_to do |format|
        if @admin_place.update(place_params)
          format.html { redirect_to @admin_place, notice: 'Place was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_place }
        else
          format.html { render :edit }
          format.json { render json: @admin_place.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/places/1
    def destroy
      @admin_place.destroy
      respond_to do |format|
        format.html { redirect_to admin_places_url, notice: 'Place was successfully destroyed.' }
        format.json { head :no_content }
      end
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

