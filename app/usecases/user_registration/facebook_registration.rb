# frozen_string_literal: true

module UserRegistration
  class FacebookRegistration
    class << self
      def call(auth)
        ActiveRecord::Base.transaction do
          @login_user = User.find_or_create_by(name: auth[:info][:name]) do |user|
            user.name  = auth[:info][:name]
            user.email = auth[:info][:email]
            user.provider = auth[:provider]
            user.uid      = auth[:uid]
            user.nickname = auth[:extra][:raw_info][:username]
            user.image_url = auth[:info][:image] || 'no_photo.jpeg'

            if auth[:credentials].present?
              user.access_token = auth[:credentials][:token]
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
end
