# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :login?
  before_action :application_log_output
  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def current_user
    @current_user ||= User.find(Base64.decode64(session[:encrypted_user_id])) if session[:encrypted_user_id]
  rescue ActiveRecord::RecordNotFound => ar
    logger.info "ユーザ情報がありません: #{ar.message}"
  end

  def login?
    redirect_to :root if session[:encrypted_user_id].blank?
  end

  def application_log_output
    # @ltsv_logger ||= LTSV::Logger.open("log/rails_application.log")
    # @ltsv_logger.info({
    #                     pid: $PROCESS_ID,
    #                     method: request.request_method,
    #                     path: request.fullpath,
    #                     ip: request.remote_ip,
    #                     uuid: request.uuid
    #                   })
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
