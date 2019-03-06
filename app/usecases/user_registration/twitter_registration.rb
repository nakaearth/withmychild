# frozen_string_literal: true

module UserRegistration
  class TwitterRegistration
    def initialize(params)
      @params = params
    end

    def call
      ActiveRecord::Base.transaction do
        @login_user = User.find_or_create_by(name: @params[:info][:name]) do |user|
          user.name  = @params[:info][:name]
          user.email = @params[:info][:email]
          user.provider = @params[:provider]
          user.uid      = @params[:uid]
          user.nickname = @params[:info][:nickname]
          user.image_url = @params[:info][:image] || 'no_photo.jpeg'

          if @params[:credentials].present?
            user.access_token = @params[:credentials][:token]
            user.secret_token = @params[:credentials][:secret]
          end
        end

        @login_user.save!
        @login_user
      end
      # rescue Faraday::TimeoutError => e
      #   puts 'ELへの登録失敗'
      #   puts e.message
    end
  end
end
