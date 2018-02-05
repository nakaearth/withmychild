# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    before_action :valid_api_token?

    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404

    def render_404
      render file: "#{Rails.root}/public/404.html", status: 404
    end

    def valid_api_token?
      return head :bad_request unless params[:secreat_key]

      AppToken.exists?(application_id: params[:application_id], secreat_key: params[:secreat_key], version_id: params[:version_id])
    end
  end
end
