# frozen_string_literal: true
module Api
  class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :null_session

    # before_action :decrypted

    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404

    def render_404
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end
end
